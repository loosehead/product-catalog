package com.elpudu.productos.catalogo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.elpudu.productos.catalogo.domain.Category;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
public class CategoryDaoImpl extends HibernateDaoSupport implements CategoryDao {
	
	
	@Autowired
	public CategoryDaoImpl(HibernateTemplate hibernateTemplate){
		super();
		this.setHibernateTemplate(hibernateTemplate);
	}
	
	

	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public Category create(Category category) {
		getHibernateTemplate().persist(category);
		return category;
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public void delete(Category category) {
		getHibernateTemplate().delete(category);
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public Category update(Category category) {
		getHibernateTemplate().update(category);
		return category;
	}
	
	@SuppressWarnings("unchecked")
	public Category getById(Integer id) {
		
		List<Category> categories = getHibernateTemplate().findByNamedParam(
				"Select p from Category p left join fetch p.products where p.id = :id", "id", id);
		
		if (!categories.isEmpty()) {
			return categories.get(0);
		}
		
		return null;
	}



	@SuppressWarnings("unchecked")
	public List<Category> getAll() {
		return getHibernateTemplate().loadAll(Category.class);
	}

	
}
