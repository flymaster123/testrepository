
package com.travel;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@org.springframework.boot.autoconfigure.SpringBootApplication
public class SpringBootApplication extends SpringBootServletInitializer implements WebMvcConfigurer {
	public static void main(String[] args) {
		SpringApplication.run(SpringBootApplication.class, args);
	}

	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.setOrder(Integer.MIN_VALUE);
		registry.addResourceHandler(new String[] { "/AgodaPartnerVerification.htm" })
				.addResourceLocations(new String[] { "AgodaPartnerVerification.htm" });
		registry.addResourceHandler(new String[] { "/robots.txt" }).addResourceLocations(new String[] { "robots.txt" });
		registry.addResourceHandler(new String[] { "/sitemap.xml" })
				.addResourceLocations(new String[] { "sitemap.xml" });
		registry.addResourceHandler(new String[] { "/resources/**" })
				.addResourceLocations(new String[] { "/resources/" });
	}

	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(new Class[] { SpringBootApplication.class });
	}
}