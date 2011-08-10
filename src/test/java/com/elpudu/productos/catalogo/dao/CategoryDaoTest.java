package com.elpudu.productos.catalogo.dao;

import java.util.List;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.Category;


public class CategoryDaoTest extends AbstractPuduTest {
	
	@Autowired
	private CategoryDao categoryDao;
	
	private Category category;
	
	@Before
	public void init() {
		category = new Category();
		category.setName("hola");
		category = categoryDao.create(category);
	}
	
	@After
	public void cleanUp() {
		categoryDao.delete(category);
	}

	@Test
	public void testGetAll() {
		
		List<Category> categories = categoryDao.getAll();
		Assert.assertEquals(1, categories.size());
		Assert.assertEquals(category, categories.get(0));
	}
	
}
