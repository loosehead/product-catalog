package com.elpudu.productos.catalogo.domain;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Transient;

@Entity
public class Product implements Serializable {
	
	private static final long serialVersionUID = 7049748595649995566L;

	private static final int MAX_DESCRIPTION_LENGTH = 100;

	@Id
	@GeneratedValue
	private Integer id;
	
	@Column(length=255, nullable=false)
	private String name;
	
	@Column(length=255)
	private String name_es;
	
	@Column(length=255)
	private String name_sv;
	
	@Column(length=20, nullable=false, unique=true)
	private String code;
	
	@Column(length=1024)
	private String description;
	
	@Column(length=1024)
	private String description_es;
	
	@Column(length=1024)
	private String description_sv;
	
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="product")
	private List<ImageFile> images;
	
	@JoinColumn(name="smallImageId")
	@ManyToOne(cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private ImageFile smallImage;
	
	@JoinTable(name="Category_Product", joinColumns={@JoinColumn(name="product_id")}, 
			inverseJoinColumns={@JoinColumn(name="category_id")})
	@ManyToMany(cascade={CascadeType.PERSIST,CascadeType.MERGE}, fetch=FetchType.EAGER)
	private List<Category> categories;
	
	
	@Transient
	private Map<Integer, ImageFile> imagesByOrderNumber;
	
	
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

	public List<ImageFile> getImages() {
		return images;
	}

	public void setImages(List<ImageFile> images) {
		this.images = images;
		this.imagesByOrderNumber = null;
	}
	
	public void addImage(ImageFile image) {
		if (this.images == null) {
			this.images = new LinkedList<ImageFile>();
		}
		this.images.add(image);
		image.setProduct(this);
		
		this.imagesByOrderNumber = null;
	}

	public ImageFile getSmallImage() {
		return smallImage;
	}

	public void setSmallImage(ImageFile smallImage) {
		this.smallImage = smallImage;
		if (this.smallImage != null) {
			this.smallImage.setProduct(this);
			this.smallImage.setSmallImage(Boolean.TRUE);
		}
	}

	public List<Category> getCategories() {
		return categories;
	}
	
	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}
	
	public String getLocalizedName(Locale locale) {
		if (locale.getLanguage().equals("es")) {
			return this.getName_es();
		}
		
		if (locale.getLanguage().equals("sv")) {
			return this.getName_sv();
		}
		
		return this.getName();
	}
	
	public String getLocalizedDescription(Locale locale) {
		if (locale.getLanguage().equals("es")) {
			return this.getDescription_es();
		}
		
		if (locale.getLanguage().equals("sv")) {
			return this.getDescription_sv();
		}
		
		return this.getDescription();
	}
	
	public String getShortLocalizedDescription(Locale locale) {
		
		String result = getLocalizedDescription(locale);
		if (result != null) {
			
			if (result.length() > MAX_DESCRIPTION_LENGTH) {
				result = result.substring(0, MAX_DESCRIPTION_LENGTH);
				int index = result.lastIndexOf(" ");
				if (index > 0) {
					result = result.substring(0, index) + "...";
				}
			}
		}
		
		return result;
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


	public void addCategory(Category category) {
		if (this.categories == null) {
			this.categories = new LinkedList<Category>();
		}
		
		this.categories.add(category);
	}



	public Map<Integer, ImageFile> getImagesByOrderNumber() {
		
		if (this.imagesByOrderNumber == null) {
			
			this.imagesByOrderNumber = new HashMap<Integer, ImageFile>();
			if (this.images != null) {
				for (ImageFile img : this.images) {
					
					if (img.getOrderNumber() != null) {
						this.imagesByOrderNumber.put(img.getOrderNumber(), img);
					}
				}
			}
		}
		
		return this.imagesByOrderNumber;
	}
	


	/**
	 * Removes an image if there is one with the given orderNumber.
	 * Returns the image that was removed, if any.
	 * @param index
	 * @return
	 */
	public ImageFile removeImageByOrderNumber(int index) {
		
		ImageFile result = null;
		
		if (this.images != null) {
			
			Iterator<ImageFile> it = this.images.iterator();
			while (it.hasNext() && result == null) {
				ImageFile img = it.next();
				if (img.getOrderNumber() != null && img.getOrderNumber().intValue() == index) {
					
					result = img;
					it.remove();
				}
			}
		}
		
		return result;
	}


	public void removeCategory(Category category) {
		if (this.categories != null) {
			
			Iterator<Category> it = this.categories.iterator();
			while (it.hasNext()) {
				if (it.next().equals(category)) {
					it.remove();
				}
			}
		}
		
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
