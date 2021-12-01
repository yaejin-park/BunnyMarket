package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ConfigurationPropertiesScan({"com.example.demo", "data.*"})
@ComponentScan({"com.example.demo", "data.*"})
@MapperScan({"data.*"})
public class BunnyMarketApplication {

	public static void main(String[] args) {
		SpringApplication.run(BunnyMarketApplication.class, args);
	}

}
