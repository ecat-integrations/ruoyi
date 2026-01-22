package com.ruoyi;

import io.github.cdimascio.dotenv.Dotenv;
import io.github.cdimascio.dotenv.DotenvBuilder;
import io.github.cdimascio.dotenv.DotenvEntry;

import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.ConfigurableEnvironment;
import org.springframework.core.env.MapPropertySource;

import java.util.HashMap;
import java.util.Map;

// public class DotenvConfig implements ApplicationContextInitializer<ConfigurableApplicationContext> {

//     @Override
//     public void initialize(ConfigurableApplicationContext applicationContext) {
//         Dotenv dotenv = Dotenv.load();
//         ConfigurableEnvironment environment = applicationContext.getEnvironment();
//         Map<String, Object> dotenvMap = new HashMap<>();
//         for (DotenvEntry entry : dotenv.entries()) {
//             dotenvMap.put(entry.getKey(), entry.getValue());
//         }
//         environment.getPropertySources().addFirst(new MapPropertySource("dotenv", dotenvMap));
//     }
// }

public class DotenvConfig implements ApplicationContextInitializer<ConfigurableApplicationContext> {
    private final String envFileDir;

    public DotenvConfig(String envFileDir) {
        this.envFileDir = envFileDir;
    }

    @Override
    public void initialize(ConfigurableApplicationContext applicationContext) {
        DotenvBuilder dotenvBuilder = Dotenv.configure();
        if (this.envFileDir != null) {
            dotenvBuilder = dotenvBuilder.directory(this.envFileDir);
        }
        Dotenv dotenv = dotenvBuilder.load();
        ConfigurableEnvironment environment = applicationContext.getEnvironment();
        Map<String, Object> dotenvMap = new HashMap<>();
        for (DotenvEntry entry : dotenv.entries()) {
            dotenvMap.put(entry.getKey(), entry.getValue());
        }
        environment.getPropertySources().addFirst(new MapPropertySource("dotenv", dotenvMap));
    }
}