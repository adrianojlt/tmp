package com.gerrytan.pizzashop;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "topping")
public class Topping {
	@Id
	@GeneratedValue
	private long id;
	
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "pizza_id", referencedColumnName = "id")
	private Pizza pizza;

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

	public Pizza getPizza() {
		return pizza;
	}

	public void setPizza(Pizza pizza) {
		this.pizza = pizza;
	}
	
}
