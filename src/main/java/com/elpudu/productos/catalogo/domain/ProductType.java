package com.elpudu.productos.catalogo.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ProductType implements Serializable {
	
	private static final long serialVersionUID = -7483085309416231894L;

	@Id
	@GeneratedValue
	private Integer id;
	
	@Column(length=255, nullable=false)
	private String name;
	
	@Column(length=255)
	private String name_es;
	
	@Column(length=255)
	private String name_sv;
	
	public ProductType() {}
	
	public ProductType(Integer id, String name) {
		super();
		this.id = id;
		this.name = name;
	}



	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName_es() {
		return name_es;
	}

	public void setName_es(String name_es) {
		this.name_es = name_es;
	}

	public String getName_sv() {
		return name_sv;
	}

	public void setName_sv(String name_sv) {
		this.name_sv = name_sv;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductType other = (ProductType) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductType " + this.name + "(id: " + this.id + ")";
	}
}
