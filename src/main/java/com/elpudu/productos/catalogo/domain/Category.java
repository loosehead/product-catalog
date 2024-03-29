package com.elpudu.productos.catalogo.domain;

import java.io.Serializable;
import java.util.List;
import java.util.Locale;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Transient;

@Entity
public class Category implements Serializable {

	private static final long serialVersionUID = 1481284266985863493L;
	
	@Id
	@GeneratedValue
	private Integer id;
	
	@Column(length=255, nullable=false, unique=true)
	private String name;
	
	@Column(length=255)
	private String name_es;
	
	@Column(length=255)
	private String name_sv;
	
	@ManyToMany(mappedBy="categories", fetch=FetchType.LAZY)
	private List<Product> products;
	
	@Transient
	private String currentLocaleName;
	

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
	
	public List<Product> getProducts() {
		return products;
	}
	
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	public String getLocalizedName(Locale locale) {
		if (locale.getLanguage().equals("es") && this.getName_es() != null 
				&& !this.getName_es().trim().equals("")) {
			return this.getName_es();
		}
		
		if (locale.getLanguage().equals("sv") && this.getName_sv() != null 
				&& !this.getName_sv().trim().equals("")) {
			return this.getName_sv();
		}
		
		return this.getName();
	}
	
	public void setLocalizedName(String name, Locale locale) {
		if (locale.getLanguage().equals("es")) {
			this.setName_es(name);
			
		} else {
		
			if (locale.getLanguage().equals("sv")) {
				this.setName_sv(name);
			
			} else {
				this.setName(name);
			}
		}
	}
	
	public String getCurrentLocaleName() {
		return currentLocaleName;
	}
	
	public void setCurrentLocaleName(String currentLocaleName) {
		this.currentLocaleName = currentLocaleName;
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
		Category other = (Category) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "Category " + this.name + " (id: " + this.id + ")";
	}

	public static String getSortByField(Locale locale) {
		if (locale.getLanguage().equals("es")) {
			return "name_es";
			
		} else {
		
			if (locale.getLanguage().equals("sv")) {
				return "name_sv";
			} 
		}
		
		return "name";
	}

}
