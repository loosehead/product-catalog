package com.elpudu.productos.catalogo.dao;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.ImageFile;


public class ImageFileDaoTest extends AbstractPuduTest {
	
	@Autowired
	private ImageFileDao imageFileDao;

	@Test
	public void testCreateImageFile() {
		
		ImageFile imageFile = new ImageFile();
		imageFile.setType("jpg");
		imageFile = imageFileDao.create(imageFile);
		Assert.assertNotNull(imageFile.getId());
		
		ImageFile p = imageFileDao.getById(imageFile.getId());
		Assert.assertEquals(imageFile, p);
		
		imageFileDao.delete(imageFile);
		p = imageFileDao.getById(imageFile.getId());
		Assert.assertNull(p);
	}
}
