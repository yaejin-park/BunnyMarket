package com.example.demo;


import javax.servlet.MultipartConfigElement;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.util.unit.DataSize;
import org.springframework.web.multipart.MultipartResolver;

@SpringBootApplication
@ConfigurationPropertiesScan({"com.example.demo", "data.*"})
@ComponentScan({"com.example.demo", "data.*"})
@MapperScan({"data.*"})
public class BunnyMarketApplication {
	@Bean
	public MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		DataSize megaBytes = DataSize.ofMegabytes(512);
	    factory.setMaxFileSize(megaBytes);
	    factory.setMaxRequestSize(megaBytes);
		return factory.createMultipartConfig();
	}

	@Bean
	public MultipartResolver multipartResolver() {
		org.springframework.web.multipart.commons.CommonsMultipartResolver multipartResolver = new org.springframework.web.multipart.commons.CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(512000000);
		return multipartResolver;
	}
	
	public static void main(String[] args) {
		SpringApplication.run(BunnyMarketApplication.class, args);
	}

}
