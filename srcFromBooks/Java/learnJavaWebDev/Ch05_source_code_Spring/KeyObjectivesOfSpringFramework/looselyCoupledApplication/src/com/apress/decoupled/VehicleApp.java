package com.apress.decoupled;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class VehicleApp {

	public static void main(String[] args) {
		ApplicationContext  context = new ClassPathXmlApplicationContext(
				"beans.xml");
		VehicleService contestService = (VehicleService) context
				.getBean("vehicleService");
		contestService.driver();
	}

}
