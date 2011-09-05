package com.elpudu.productos.catalogo.dao;

import java.util.List;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.Product;


public class CategoryDaoTest extends AbstractPuduTest {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ProductDao productDao;
	
	private Category category;
	
	private Category categoryWithProducts;
	private Product product;
	
	@Before
	public void init() {
		category = new Category();
		category.setName("hola");
		category = categoryDao.create(category);
		
		categoryWithProducts = new Category();
		categoryWithProducts.setName("categoryWithProducts");
		categoryWithProducts = categoryDao.create(categoryWithProducts);
		
		product = new Product();
		product.setCode("tt1");
		product.setName("x12344");
		product = productDao.create(product);
		
		product.addCategory(categoryWithProducts);
		product = productDao.update(product);
		
		categoryWithProducts = categoryDao.getById(categoryWithProducts.getId());
	}
	
	@After
	public void cleanUp() {
		categoryDao.delete(category);
		
		productDao.delete(product);
		categoryDao.delete(categoryWithProducts);
	}

//	@Test
//	public void testGetAll() {
//		
//		List<Category> categories = categoryDao.getAll();
//		Assert.assertEquals(2, categories.size());
//		Assert.assertTrue(categories.contains(category));
//		Assert.assertTrue(categories.contains(categoryWithProducts));
//	}
	
	@Test
	public void testDeleteCategory() {
		
		categoryDao.delete(categoryWithProducts);
		product = productDao.getById(product.getId());
		
		Assert.assertTrue(product.getCategories().isEmpty());
		
		// se inserta nuevamente para que se pueda borrar despues
		categoryWithProducts = new Category();
		categoryWithProducts.setName("categoryWithProducts");
		categoryWithProducts = categoryDao.create(categoryWithProducts);
	}
	
}
