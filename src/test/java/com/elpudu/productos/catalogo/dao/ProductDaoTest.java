package com.elpudu.productos.catalogo.dao;

import java.util.LinkedList;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;


public class ProductDaoTest extends AbstractPuduTest {
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;

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
	
	@Test
	public void testPropagateCategory() {
		
		Category category = new Category();
		category.setName("test");
		
		Product product = new Product();
		List<Category> categories = new LinkedList<Category>();
		categories.add(category);
		product.setCategories(categories);
		product.setName("test");
		
		product = productDao.create(product);
		
		Assert.assertEquals(1, product.getCategories().size());
		Assert.assertNotNull(product.getCategories().get(0).getId());
		
		category = categoryDao.getById(product.getCategories().get(0).getId());
		
		Assert.assertEquals(1, category.getProducts().size());
		Assert.assertEquals(product, category.getProducts().get(0));
		
		productDao.delete(product);
		categoryDao.delete(category);
	}
}
