package com.ruoyi;

import org.springframework.context.ApplicationContextInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import com.ecat.core.EcatCore;

/**
 * EcatCoreInitializer 用于在 Spring 应用上下文初始化时注册 EcatCore 实例。
 * 
 * @author coffee
 */
public class EcatCoreInitializer implements ApplicationContextInitializer<ConfigurableApplicationContext> {
    @Override
    public void initialize(ConfigurableApplicationContext applicationContext) {
        EcatCore ecatCore = EcatCore.getInstance();
        if (ecatCore != null) {
            ((DefaultListableBeanFactory) applicationContext.getBeanFactory()).registerSingleton("ecatCore", ecatCore);
        }
    }
}
