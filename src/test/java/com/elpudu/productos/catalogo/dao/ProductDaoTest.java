package com.elpudu.productos.catalogo.dao;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;


public class ProductDaoTest extends AbstractPuduTest {
	
	@Autowired
	private ProductDao productDao;

	@Test
	public void testCreateProduct() {
		
		Product product = new Product();
		product.setName("test");
		product.setImage(new ImageFile());
		product.getImage().setFileName("test");
		product.getImage().setType("jpg");
		
		product = productDao.create(product);
		Assert.assertNotNull(product.getId());
		
		Product p = productDao.getById(product.getId());
		Assert.assertEquals(product, p);
		Assert.assertNotNull(p.getImage());
		Assert.assertNotNull(p.getImage().getId());
		Assert.assertNotNull(p.getImage().getType());
		
		productDao.delete(product);
		p = productDao.getById(product.getId());
		Assert.assertNull(p);
	}
}
