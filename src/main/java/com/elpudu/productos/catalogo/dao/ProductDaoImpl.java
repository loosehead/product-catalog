package com.elpudu.productos.catalogo.dao;

import java.util.Iterator;
import java.util.List;

import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceContextType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
@PersistenceContext(type = PersistenceContextType.EXTENDED)
public class ProductDaoImpl extends HibernateDaoSupport implements ProductDao {
	
	
	@Autowired
	public ProductDaoImpl(HibernateTemplate hibernateTemplate){
		super();
		this.setHibernateTemplate(hibernateTemplate);
	}
	
	

	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public Product create(Product product) {
		getHibernateTemplate().persist(product);
		return product;
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public void delete(Product product) {
		
		deleteSmallImage(product);		
		getHibernateTemplate().delete(product);
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public Product update(Product product) {
		getHibernateTemplate().update(product);
		return product;
	}
	
	@SuppressWarnings("unchecked")
	public Product getById(final Integer id) {
		
		Product product = null;
			
		List<Product> products = getHibernateTemplate().findByNamedParam(
				"Select p from Product p left join fetch p.smallImage " +
//				"left join fetch p.categories " +
				"left join fetch p.images i where p.id = :id " +
				"order by i.orderNumber", 
				new String[]{"id"}, 
				new Object[] {id});
		
		if (products != null && !products.isEmpty()) {
			product = products.get(0);
			
			if (product.getImages() != null) {
				
				Iterator<ImageFile> it = product.getImages().iterator();
				while (it.hasNext()) {
					
					if (it.next().isSmallImage()) {
						it.remove();
					}
				}
			}
		}
		
		
		return product;
		
		/*
		HibernateCallback callback = new HibernateCallback() {
				public Object doInHibernate(Session session)  {
					Product product = (Product) session.get(Product.class, id);
					if (product != null && product.getImages() != null) {
						
						Iterator<ImageFile> it = product.getImages().iterator();
						while (it.hasNext()) {
							
							if (it.next().isSmallImage()) {
								it.remove();
							}
						}
					}
					
					return product;
				}
			};
			return (Product) getHibernateTemplate().execute(callback);
			*/
	}



	@SuppressWarnings("unchecked")
	public List<Product> getAll() {
		return getHibernateTemplate().loadAll(Product.class);
	}



	public Product getByCode(String code) {
		
		@SuppressWarnings("unchecked")
		List<Product> products = getHibernateTemplate().findByNamedParam(
				"Select p from Product p where p.code = :code", "code", code);
		
		if (products != null && !products.isEmpty()) {
			return products.get(0);
		}
		
		return null;
	}



	@SuppressWarnings("unchecked")
	public List<Product> getByCategoryId(Integer categoryId) {
		
		List<Product> products = getHibernateTemplate().findByNamedParam(
				"Select p from Product p left join fetch p.smallImage, " +
				"IN(p.categories) c where c.id = :categoryId", 
				"categoryId", categoryId);
		
		return products;
	}



	public void deleteSmallImage(Product product) {
		
		ImageFile smallImage = product.getSmallImage();
		if (smallImage != null) {
			product.setSmallImage(null);
			getHibernateTemplate().update(product);
			getHibernateTemplate().delete(smallImage);
		}
	}



	@SuppressWarnings("unchecked")
	public List<Product> getUnassignedProducts() {
		List<Product> products = getHibernateTemplate().find(
				"Select p from Product p left join fetch p.smallImage where not exists " +
				"(select c from Category c, IN(c.products) p2 where p2 = p)");
		
		return products;
	}

}
