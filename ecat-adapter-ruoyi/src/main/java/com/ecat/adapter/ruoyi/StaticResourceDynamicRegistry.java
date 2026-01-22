package com.ecat.adapter.ruoyi;

import cn.hutool.core.util.ReflectUtil;
import cn.hutool.core.util.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.handler.SimpleUrlHandlerMapping;
import org.springframework.web.util.UrlPathHelper;

import javax.servlet.ServletContext;
import java.util.Collections;
import java.util.Map;

import org.springframework.stereotype.Component;

// 静态资源动态加载器
// https://blog.csdn.net/lqzkcx3/article/details/122641111
// TODO: 需完善新增静态资源的访问权限校验，目前通过此方法添加的静态资源不受任何权限控制，全部放行

/**
 * StaticResourceDynamicRegistry 用于动态注册静态资源处理器。
 * 它实现了 ServletContextAware 接口，以便能够访问 Servlet 上下文。
 * 通过 registry 方法可以注册新的静态资源处理器。
 * 
 * @author coffee
 */
@Component
public class StaticResourceDynamicRegistry implements ServletContextAware {

    @Autowired
    private ApplicationContext applicationContext;

    private ServletContext servletContext;

    public void registry(String resourceHandler, String resourceLocations) {
        registerHandlersForAdditionalStatisResource(Collections.singletonMap(resourceHandler, resourceLocations));
    }

    private void registerHandlersForAdditionalStatisResource(Map<String, String> registerMapping) {
        final UrlPathHelper mvcUrlPathHelper = applicationContext.getBean("mvcUrlPathHelper", UrlPathHelper.class);
        final ContentNegotiationManager mvcContentNegotiationManager = applicationContext
               .getBean("mvcContentNegotiationManager", ContentNegotiationManager.class);
        final ServletContext servletContext = this.servletContext;
        final HandlerMapping resourceHandlerMapping = applicationContext.getBean("resourceHandlerMapping",
                HandlerMapping.class);

        @SuppressWarnings("unchecked")
        final Map<String, Object> handlerMap = (Map<String, Object>) ReflectUtil.getFieldValue(resourceHandlerMapping,
                "handlerMap");

        final ResourceHandlerRegistry resourceHandlerRegistry = new ResourceHandlerRegistry(applicationContext,
                servletContext, mvcContentNegotiationManager, mvcUrlPathHelper);

        for (Map.Entry<String, String> entry : registerMapping.entrySet()) {
            String urlPath = entry.getKey();
            String resourceLocationsValue = entry.getValue();
            final String urlPathDealed = StrUtil.appendIfMissing(urlPath, "/**");
            final String resourceLocationsDealed = StrUtil.appendIfMissing(resourceLocationsValue, "/");

            handlerMap.remove(urlPathDealed);
            resourceHandlerRegistry.addResourceHandler(urlPathDealed)
                   .addResourceLocations(resourceLocationsDealed);
        }

        final Map<String, ?> additionalUrlMap = ReflectUtil
               .<SimpleUrlHandlerMapping>invoke(resourceHandlerRegistry, "getHandlerMapping").getUrlMap();

        ReflectUtil.<Void>invoke(resourceHandlerMapping, "registerHandlers", additionalUrlMap);
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}    
