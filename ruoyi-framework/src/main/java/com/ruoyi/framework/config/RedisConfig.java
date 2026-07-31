package com.ruoyi.framework.config;

import io.lettuce.core.ClientOptions;
import io.lettuce.core.SocketOptions;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.RedisPassword;
import org.springframework.data.redis.connection.RedisStandaloneConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceClientConfiguration;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.connection.lettuce.LettucePoolingClientConfiguration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import java.time.Duration;

/**
 * redis配置
 *
 * @author ruoyi
 */
@Configuration
@EnableCaching
public class RedisConfig extends CachingConfigurerSupport
{
    /**
     * 自定义 LettuceConnectionFactory：根治公网 redis 的连接楔住（redis-wedge）。
     *
     * <p>现象：ruoyi 用 Lettuce 持久连接连公网 redis（{@code 81.70.37.141:5556}），空闲连接被 NAT/防火墙
     * 静默丢弃成 half-open（TCP 表面活、实际死）。getInfo 等 token 校验走 redis 命中死连接即挂起/超时，
     * 重启 core 才恢复（Lettuce 重连），间歇复发——表现为"后端总有病"。
     *
     * <p>三道防线：
     * <ul>
     *   <li>TCP keepAlive（idle=15s/interval=10s/count=3）：netty socket 级秒级探活 half-open → Lettuce 自动重连。
     *       覆盖共享原生连接（普通 GET/SET/EVAL 走它，连接池管不到这条——这是普通命令楔住的主路径）。</li>
     *   <li>池 testOnBorrow + testWhileIdle + 30s eviction：若走连接池，借出/空闲期校验连接活性（防御性覆盖池化路径）。</li>
     *   <li>maxWait 有限值（原 yml {@code -1ms} = 池耗尽无限阻塞，是 API 整体挂死的帮凶）→ 改 3s 快速失败。</li>
     * </ul>
     * host/port/db/password/commandTimeout 仍读 {@link RedisProperties}（application.yml 真相源，本 bean 不重复硬编码）。
     */
    @Bean
    public LettuceConnectionFactory redisConnectionFactory(RedisProperties redisProperties)
    {
        SocketOptions socketOptions = SocketOptions.builder()
                .keepAlive(SocketOptions.KeepAliveOptions.builder()
                        .enable()
                        .idle(Duration.ofSeconds(15))
                        .interval(Duration.ofSeconds(10))
                        .count(3)
                        .build())
                .build();
        ClientOptions clientOptions = ClientOptions.builder()
                .socketOptions(socketOptions)
                .build();

        GenericObjectPoolConfig<Object> poolConfig = new GenericObjectPoolConfig<>();
        RedisProperties.Pool pool = redisProperties.getLettuce().getPool();
        if (pool != null)
        {
            poolConfig.setMaxTotal(pool.getMaxActive());
            poolConfig.setMaxIdle(pool.getMaxIdle());
            poolConfig.setMinIdle(pool.getMinIdle());
        }
        // maxWait 原值 -1ms（无限阻塞）是 wedge 时 API 挂死帮凶；强制有限值快速失败（不沿用 yml 的 -1ms）
        // 用 millis 版 API（旧版 commons-pool2 兼容，Duration 版仅 2.11+ 有）
        poolConfig.setMaxWaitMillis(3000L);
        poolConfig.setTestOnBorrow(true);
        poolConfig.setTestWhileIdle(true);
        poolConfig.setTimeBetweenEvictionRunsMillis(30000L);

        Duration commandTimeout = redisProperties.getTimeout() != null
                ? redisProperties.getTimeout() : Duration.ofSeconds(3);

        LettuceClientConfiguration clientConfig = LettucePoolingClientConfiguration.builder()
                .clientOptions(clientOptions)
                .commandTimeout(commandTimeout)
                .poolConfig(poolConfig)
                .build();

        RedisStandaloneConfiguration redisConfig = new RedisStandaloneConfiguration();
        redisConfig.setHostName(redisProperties.getHost());
        redisConfig.setPort(redisProperties.getPort());
        redisConfig.setDatabase(redisProperties.getDatabase());
        if (redisProperties.getPassword() != null)
        {
            redisConfig.setPassword(RedisPassword.of(redisProperties.getPassword()));
        }
        return new LettuceConnectionFactory(redisConfig, clientConfig);
    }

    @Bean
    @SuppressWarnings(value = { "unchecked", "rawtypes" })
    public RedisTemplate<Object, Object> redisTemplate(RedisConnectionFactory connectionFactory)
    {
        RedisTemplate<Object, Object> template = new RedisTemplate<>();
        template.setConnectionFactory(connectionFactory);

        FastJson2JsonRedisSerializer serializer = new FastJson2JsonRedisSerializer(Object.class);

        // 使用StringRedisSerializer来序列化和反序列化redis的key值
        template.setKeySerializer(new StringRedisSerializer());
        template.setValueSerializer(serializer);

        // Hash的key也采用StringRedisSerializer的序列化方式
        template.setHashKeySerializer(new StringRedisSerializer());
        template.setHashValueSerializer(serializer);

        template.afterPropertiesSet();
        return template;
    }

    @Bean
    public DefaultRedisScript<Long> limitScript()
    {
        DefaultRedisScript<Long> redisScript = new DefaultRedisScript<>();
        redisScript.setScriptText(limitScriptText());
        redisScript.setResultType(Long.class);
        return redisScript;
    }

    /**
     * 限流脚本
     */
    private String limitScriptText()
    {
        return "local key = KEYS[1]\n" +
                "local count = tonumber(ARGV[1])\n" +
                "local time = tonumber(ARGV[2])\n" +
                "local current = redis.call('get', key);\n" +
                "if current and tonumber(current) > count then\n" +
                "    return tonumber(current);\n" +
                "end\n" +
                "current = redis.call('incr', key)\n" +
                "if tonumber(current) == 1 then\n" +
                "    redis.call('expire', key, time)\n" +
                "end\n" +
                "return tonumber(current);";
    }
}
