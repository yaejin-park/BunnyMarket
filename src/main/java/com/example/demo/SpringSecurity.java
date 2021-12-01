package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import data.service.MemberService;


@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SpringSecurity extends WebSecurityConfigurerAdapter {
	@Autowired
	private MemberService memberService = new MemberService();
	private AuthSuccessHandler authSuccessHandler = new AuthSuccessHandler();
	private AuthFailureHandler authFailureHandler = new AuthFailureHandler();
	
	@Bean
	public BCryptPasswordEncoder encryptPassword() {
		return new BCryptPasswordEncoder();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberService).passwordEncoder(encryptPassword());
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable()
			.authorizeRequests()
				.antMatchers("/event/auth/**", "/advertise/auth/**", "/community/auth/**", "/product/auth/**", "/review/auth/**").authenticated()
				.anyRequest().permitAll()
				.and()
			.formLogin()
				.loginPage("/login/main")
				.loginProcessingUrl("/login/action") 
				.successHandler(authSuccessHandler)
				.failureHandler(authFailureHandler)
				.and()
			.logout()
				.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
				.logoutSuccessUrl("/login/main")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID", "remember-me", "returnUrl")
				.permitAll()
				.and()
				.sessionManagement()
				.maximumSessions(1)
				.maxSessionsPreventsLogin(false)
				.expiredUrl("/")
				.and()
				.and().rememberMe()
				.alwaysRemember(false)
				.tokenValiditySeconds(43200)
				.rememberMeParameter("remember-me");
	}
}
