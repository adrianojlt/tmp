package com.apress.decoupled;

public class VehicleService {

	private Vehicle vehicle;

	public void setVehicle(Vehicle vehicle) {
		this.vehicle = vehicle;
	}

	public void driver() {
		System.out.println(vehicle.drive());

	}

}
