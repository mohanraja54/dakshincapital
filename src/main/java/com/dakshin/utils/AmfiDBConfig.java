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
import org.springframework.core.env.Environment;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

@Configuration
@EnableJpaRepositories(
		entityManagerFactoryRef = "amfiEntityManagerFactory",
		basePackages = {"com.dakshin.amfi.dao" },
		transactionManagerRef = "amfiTransactionManager")
public class AmfiDBConfig {
	
	@Autowired
    private Environment env;

	@Bean
	@ConfigurationProperties(prefix = "amfi.datasource")
	public DataSourceProperties amfiDataSourceProperties() {
		return new DataSourceProperties();
	}
	
	@Bean
	public DataSource amfiDataSource() {
		return DataSourceBuilder.create()
       		 .driverClassName(env.getProperty("amfi.datasource.driver-class-name"))
       	        .url(env.getProperty("amfi.datasource.url"))
       	        .username(env.getProperty("amfi.datasource.username"))
       	        .password(env.getProperty("amfi.datasource.password"))
       	        .build();
	
	}
	
	 @Bean(name = "amfiTransactionManager")
     public PlatformTransactionManager amfiTransactionManager()
     {
         EntityManagerFactory factory = amfiEntityManagerFactory().getObject();
         return new JpaTransactionManager(factory);
     }
	 
	 @Bean(name = "amfiEntityManagerFactory")
     public LocalContainerEntityManagerFactoryBean amfiEntityManagerFactory() 
     {
         LocalContainerEntityManagerFactoryBean factory = new LocalContainerEntityManagerFactoryBean();
         factory.setDataSource(amfiDataSource());
         factory.setPackagesToScan(new String[]{"com.dakshin.amfi.model"});
         factory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
      
         Properties jpaProperties = new Properties();
         jpaProperties.put("hibernate.hbm2ddl.auto", env.getProperty("spring.jpa.hibernate.ddl-auto"));
         jpaProperties.put("hibernate.show-sql", env.getProperty("spring.jpa.show-sql"));
         factory.setJpaProperties(jpaProperties);
      
         return factory;
     }
		
}