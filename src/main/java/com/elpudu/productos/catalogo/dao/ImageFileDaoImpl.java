package com.elpudu.productos.catalogo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.elpudu.productos.catalogo.domain.ImageFile;

@Repository
@Transactional(propagation=Propagation.SUPPORTS, readOnly=true)
public class ImageFileDaoImpl extends HibernateDaoSupport implements ImageFileDao {
	
	
	@Autowired
	public ImageFileDaoImpl(HibernateTemplate hibernateTemplate){
		super();
		this.setHibernateTemplate(hibernateTemplate);
	}
	
	

	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public ImageFile create(ImageFile imageFile) {
		getHibernateTemplate().persist(imageFile);
		return imageFile;
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public void delete(ImageFile imageFile) {
		getHibernateTemplate().delete(imageFile);
	}
	
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public ImageFile update(ImageFile imageFile) {
		getHibernateTemplate().update(imageFile);
		return imageFile;
	}
	
	public ImageFile getById(Integer id) {
		return (ImageFile) getHibernateTemplate().get(ImageFile.class, id);
	}



	@SuppressWarnings("unchecked")
	public List<ImageFile> getAll() {
		return getHibernateTemplate().loadAll(ImageFile.class);
	}

}
