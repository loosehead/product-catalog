package com.elpudu.productos.catalogo.domain;

import java.io.Serializable;

public class Contact implements Serializable {
	
	private static final long serialVersionUID = 315866661827408616L;

	private String name;
	
	private String phoneNumber;
	
	private String email;
	
	private String address;
	
	private String comment;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
	@Override
	public String toString() {
		return "Contact " + this.name;
	}

}
