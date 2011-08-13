package com.elpudu.productos.catalogo.dao;

import java.util.List;

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
		getHibernateTemplate().delete(product);
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public Product update(Product product) {
		getHibernateTemplate().update(product);
		return product;
	}
	
	@SuppressWarnings("unchecked")
	public Product getById(Integer id) {
		
		List<Product> products = getHibernateTemplate().findByNamedParam(
				"Select p from Product p left join fetch p.smallImage " +
				"left join fetch p.images i where p.id = :id order by i.orderNumber", "id", id);
		
		if (products != null && !products.isEmpty()) {
			return products.get(0);
		}
		
		return null;
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

}
