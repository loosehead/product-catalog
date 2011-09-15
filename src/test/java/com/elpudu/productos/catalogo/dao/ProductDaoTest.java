package com.elpudu.productos.catalogo.dao;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

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
	private Product productWithoutCategories;
	private Product productWithImages;
	private Product firstProduct;
	private Product secondProduct;
	
	private Category category1;
	private Category category2;
	private Category category3;
	private Category categoryBoth;
	private Category categoryNone;
	private ImageFile smallImage;
	private ImageFile image1;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private ImageFileDao imageFileDao;
	
	@Before
	public void init() {
		category1 = buildCategory("c1");
		category2 = buildCategory("c2");
		category3 = buildCategory("c3");
		categoryBoth = buildCategory("cboth");
		categoryNone = buildCategory("cnone");
		
		product1 = buildProduct("p1", "p1", category1, categoryBoth);
		product2 = buildProduct("p2", "p2", category2, categoryBoth);
		productWithoutCategories = buildProduct("p3", "p3", new Category[]{});
		productWithImages = buildProduct("pImg1", "pImg1", category3);
		
		firstProduct = buildProduct("A", "A", category3);
		secondProduct = buildProduct("B", "B", category3);
		firstProduct.setName_es("B");
		firstProduct = productDao.update(firstProduct);
		secondProduct.setName_es("A");
		secondProduct = productDao.update(secondProduct);
		
		smallImage = buildSmallImage(3, product1);
		
		image1 = buildImage(0, productWithImages);
	}

	private ImageFile buildSmallImage(Integer orderNumber, Product product) {
		ImageFile small = new ImageFile();
		small.setOrderNumber(orderNumber);
		product.setSmallImage(small);
		
		product = productDao.update(product);
		
		return product.getSmallImage();
	}
	
	private ImageFile buildImage(Integer orderNumber, Product product) {
		ImageFile img = new ImageFile();
		img.setOrderNumber(orderNumber);
		product.addImage(img);
		
		product = productDao.update(product);
		
		return product.getImagesByOrderNumber().get(orderNumber);
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
		productDao.delete(productWithoutCategories);
		productDao.delete(productWithImages);
		productDao.delete(firstProduct);
		productDao.delete(secondProduct);
		
		categoryDao.delete(category1);
		categoryDao.delete(category2);
		categoryDao.delete(category3);
		categoryDao.delete(categoryBoth);
		categoryDao.delete(categoryNone);
	}

	@Test
	public void testCreateProduct() {
		
		Product product = new Product();
		product.setName("test");
		product.setCode("123");
		
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
		product.setCode("test1");
		
		product = productDao.create(product);
		
		Assert.assertEquals(1, product.getCategories().size());
		Assert.assertNotNull(product.getCategories().get(0).getId());
		
		category = categoryDao.getById(product.getCategories().get(0).getId());
		
		Assert.assertEquals(1, category.getProducts().size());
		Assert.assertEquals(product, category.getProducts().get(0));
		
		categoryDao.delete(category);
		productDao.delete(product);
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
		
		List<Product> products = productDao.getByCategoryId(category1.getId());
		Assert.assertEquals(1, products.size());
		Assert.assertEquals(product1, products.get(0));
		
		Assert.assertNotNull(products.get(0).getSmallImage().getId());
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
		Assert.assertFalse(result.getImages().contains(smallImage));
		
	}
	
	
	@Test
	public void testGetByIdWithImagesNotSmall() {
		
		ImageFile image2 = new ImageFile();
		image2.setOrderNumber(2);
		product1.addImage(image2);		
		
		ImageFile image1 = new ImageFile();
		image1.setOrderNumber(1);
		product1.addImage(image1);
		
		
		product1 = productDao.update(product1);
		
		Product result = productDao.getById(product1.getId());
		Assert.assertEquals(2, result.getImages().size());
		Assert.assertEquals(new Integer(1), result.getImages().get(0).getOrderNumber());
		Assert.assertEquals(new Integer(2), result.getImages().get(1).getOrderNumber());
		Assert.assertEquals(Integer.valueOf(3), result.getSmallImage().getOrderNumber());
		Assert.assertFalse(result.getImages().contains(smallImage));
		
	}
	
	@Test
	public void testGetUnassignedProducts() {
		
		List<Product> products = productDao.getUnassignedProducts();
		Assert.assertEquals(1, products.size());
		Assert.assertEquals(productWithoutCategories, products.get(0));
	}
	
	@Test
	public void testGetById() {
		
		Product p = productDao.getById(product1.getId());
		Assert.assertNotNull(p);
		Assert.assertEquals(product1, p);
	}
	
	@Test
	public void testDeleteImage() {
		
		productDao.deleteImageByOrderNumber(productWithImages, 0);
		
		ImageFile img = imageFileDao.getById(image1.getId());
		Assert.assertNull(img);
	}
	
	@Test
	public void testGetByCategoryIdEnglish() {
		
		List<Product> products = productDao.getByCategoryId(category3.getId(), new Locale("en"));
		Assert.assertFalse(products.isEmpty());
		Assert.assertTrue(products.indexOf(firstProduct) < products.indexOf(secondProduct));
	}
	
	@Test
	public void testGetByCategoryIdSpanish() {
		
		List<Product> products = productDao.getByCategoryId(category3.getId(), new Locale("es"));
		Assert.assertFalse(products.isEmpty());
		Assert.assertTrue(products.indexOf(secondProduct) < products.indexOf(firstProduct));
	}
}
