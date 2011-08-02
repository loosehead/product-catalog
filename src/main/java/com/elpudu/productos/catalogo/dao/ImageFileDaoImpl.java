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
	
	

	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public ImageFile create(ImageFile imageFile) {
		getHibernateTemplate().persist(imageFile);
		return imageFile;
	}
	
	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public void delete(ImageFile imageFile) {
		getHibernateTemplate().delete(imageFile);
	}
	
	@Override
	@Transactional(readOnly=false, propagation = Propagation.REQUIRED)
	public ImageFile update(ImageFile imageFile) {
		getHibernateTemplate().update(imageFile);
		return imageFile;
	}
	
	@Override
	public ImageFile getById(Integer id) {
		return (ImageFile) getHibernateTemplate().get(ImageFile.class, id);
	}



	@SuppressWarnings("unchecked")
	@Override
	public List<ImageFile> getAll() {
		return getHibernateTemplate().loadAll(ImageFile.class);
	}

}
