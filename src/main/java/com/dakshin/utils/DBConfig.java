package com.dakshin.utils;

import java.util.Properties;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@EnableJpaRepositories(
		entityManagerFactoryRef = "mfEntityManagerFactory",
		basePackages = {"com.dakshin.dao" },
		transactionManagerRef = "mfTransactionManager")
public class DBConfig {
	
	@Autowired
    private Environment env;
	
	@Primary
	@Bean
	@ConfigurationProperties(prefix = "mf.datasource")
	public DataSourceProperties dataSourceProperties() {
		return new DataSourceProperties();
	}

	@Primary
    @Bean
	public DataSource dataSource() {
		 return DataSourceBuilder.create()
        		 .driverClassName(env.getProperty("mf.datasource.driver-class-name"))
        	        .url(env.getProperty("mf.datasource.url"))
        	        .username(env.getProperty("mf.datasource.username"))
        	        .password(env.getProperty("mf.datasource.password"))
        	        .build();
	}
	@Primary
     @Bean(name = "mfTransactionManager")
	 public PlatformTransactionManager mfTransactionManager()
	 {
	     EntityManagerFactory factory = mfEntityManagerFactory().getObject();
	     return new JpaTransactionManager(factory);
	 }
	@Primary
	 @Bean(name = "mfEntityManagerFactory")
     public LocalContainerEntityManagerFactoryBean mfEntityManagerFactory()
     {
         LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
         factory.setDataSource(dataSource());
         factory.setPackagesToScan(new String[]{"com.dakshin.model"});
         factory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
      
         Properties jpaProperties = new Properties();
         jpaProperties.put("hibernate.hbm2ddl.auto", env.getProperty("spring.jpa.hibernate.ddl-auto"));
         jpaProperties.put("hibernate.show-sql", env.getProperty("spring.jpa.show-sql"));
         factory.setJpaProperties(jpaProperties);
      
         return factory;
     }
}