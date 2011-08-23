package com.elpudu.productos.catalogo.dao;

import java.util.LinkedList;
import java.util.List;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.elpudu.productos.catalogo.AbstractPuduTest;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;


public class ProductDaoTest extends AbstractPuduTest {
	
	private Product product1;
	private Product product2;
	private Category category1;
	private Category category2;
	private Category categoryBoth;
	private Category categoryNone;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Before
	public void init() {
		category1 = buildCategory("c1");
		category2 = buildCategory("c2");
		categoryBoth = buildCategory("cboth");
		categoryNone = buildCategory("cnone");
		
		product1 = buildProduct("p1", "p1", category1, categoryBoth);
		product2 = buildProduct("p2", "p2", category2, categoryBoth);
	}

	private Category buildCategory(String name) {
		Category category = new Category();
		category.setName(name);
		category = categoryDao.create(category);
		
		return category;
	}

	private Product buildProduct(String name, String code, Category... categories) {
		Product product = new Product();
		product.setName(name);
		product.setCode(code);
		
		product = productDao.create(product);
		
		for (Category category : categories) {
			product.addCategory(category);
		}
		
		product = productDao.update(product);
		
		return product;
	}
	
	@After
	public void cleanup() {
		productDao.delete(product1);
		productDao.delete(product2);
		
		categoryDao.delete(category1);
		categoryDao.delete(category2);
		categoryDao.delete(categoryBoth);
		categoryDao.delete(categoryNone);
	}

	@Test
	public void testCreateProduct() {
		
		Product product = new Product();
		product.setName("test");
		
		ImageFile image = new ImageFile();
		image.setFileName("test");
		image.setType("jpg");
		product.addImage(image);
		
		product = productDao.create(product);
		Assert.assertNotNull(product.getId());
		
		Product p = productDao.getById(product.getId());
		Assert.assertEquals(product, p);
		Assert.assertNotNull(p.getImages());
		Assert.assertEquals(1, p.getImages().size());
		Assert.assertNotNull(p.getImages().get(0).getId());
		Assert.assertNotNull(p.getImages().get(0).getType());
		
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
	
	@Test
	public void testGetByCategory1() {
		
		List<Product> products = productDao.getByCategoryId(category1.getId());
		Assert.assertEquals(1, products.size());
		Assert.assertEquals(product1, products.get(0));
	}
	
	@Test
	public void testGetByCategory2() {
		
		List<Product> products = productDao.getByCategoryId(category2.getId());
		Assert.assertEquals(1, products.size());
		Assert.assertEquals(product2, products.get(0));
	}
	
	@Test
	public void testGetByCategory3() {
		
		List<Product> products = productDao.getByCategoryId(categoryBoth.getId());
		Assert.assertEquals(2, products.size());
		Assert.assertTrue(products.contains(product1));
		Assert.assertTrue(products.contains(product2));
	}
	
	@Test
	public void testGetByCategory4() {
		
		List<Product> products = productDao.getByCategoryId(categoryNone.getId());
		Assert.assertTrue(products.isEmpty());
	}
	
	@Test
	public void testGetByCategoryWithSmallImage() {
		
		ImageFile smallImage = new ImageFile();
		product1.setSmallImage(smallImage);
		product1 = productDao.update(product1);
		
		List<Product> products = productDao.getByCategoryId(category1.getId());
		Assert.assertEquals(1, products.size());
		Assert.assertEquals(product1, products.get(0));
		
		Assert.assertNotNull(products.get(0).getSmallImage().getId());
		
		product1.setSmallImage(null);
		product1 = productDao.update(product1);
	}
	
	@Test
	public void testGetByIdWithImages() {
		
		ImageFile image3 = new ImageFile();
		image3.setOrderNumber(3);
		product1.addImage(image3);
		
		ImageFile image1 = new ImageFile();
		image1.setOrderNumber(1);
		product1.addImage(image1);
		
		ImageFile image2 = new ImageFile();
		image2.setOrderNumber(2);
		product1.addImage(image2);		
		
		product1 = productDao.update(product1);
		
		Product result = productDao.getById(product1.getId());
		Assert.assertEquals(3, result.getImages().size());
		Assert.assertEquals(new Integer(1), result.getImages().get(0).getOrderNumber());
		Assert.assertEquals(new Integer(2), result.getImages().get(1).getOrderNumber());
		Assert.assertEquals(new Integer(3), result.getImages().get(2).getOrderNumber());
		
	}
}