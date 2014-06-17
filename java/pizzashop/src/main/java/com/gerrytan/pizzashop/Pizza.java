package com.gerrytan.pizzashop;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "pizza")
public class Pizza {
	@Id @GeneratedValue private long id;
	private String name;
	private double price;
	
	@OneToMany(mappedBy = "pizza", fetch = FetchType.LAZY)
	private List<Topping> toppings;
	
	/**********************************************************************/
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public List<Topping> getToppings() {
		return toppings;
	}
	public void setToppings(List<Topping> toppings) {
		this.toppings = toppings;
	}
	
}
