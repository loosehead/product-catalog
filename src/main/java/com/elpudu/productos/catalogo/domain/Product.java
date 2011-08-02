package com.elpudu.productos.catalogo.domain;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Product implements Serializable {
	
	private static final long serialVersionUID = 7049748595649995566L;

	@Id
	@GeneratedValue
	private Integer id;
	
	@Column(length=255, nullable=false)
	private String name;
	
	@Column(length=255)
	private String name_es;
	
	@Column(length=255)
	private String name_sv;
	
	@Column(length=20)
	private String code;
	
	@Column(length=1024)
	private String description;
	
	@Column(length=1024)
	private String description_es;
	
	@Column(length=1024)
	private String description_sv;
	
	@ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private ImageFile image;
	
	@ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private ImageFile smallImage;
	
	@ManyToOne(cascade={CascadeType.PERSIST,CascadeType.MERGE})
	private ProductType productType;
	
	
	public Product() {}
	

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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDescription_es() {
		return description_es;
	}

	public void setDescription_es(String description_es) {
		this.description_es = description_es;
	}

	public String getDescription_sv() {
		return description_sv;
	}

	public void setDescription_sv(String description_sv) {
		this.description_sv = description_sv;
	}

	public ImageFile getImage() {
		return image;
	}

	public void setImage(ImageFile image) {
		this.image = image;
	}

	public ImageFile getSmallImage() {
		return smallImage;
	}

	public void setSmallImage(ImageFile smallImage) {
		this.smallImage = smallImage;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
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
		Product other = (Product) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "Product " + this.name + " (id: " + this.id + ")";
	}

}
