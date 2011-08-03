package com.elpudu.productos.catalogo.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.Product;


@Controller
public class ProductController {
	
	private static Log log = LogFactory.getLog(ProductController.class);
	
	
	@Autowired
	private ProductDao productDao;
	

	@RequestMapping("/admin/productList.html")
	@ModelAttribute("products")
	public List<Product> getProducts() {
		return productDao.getAll();
	}

	@RequestMapping("/admin/productDetails.html")
	@ModelAttribute("product")
	public Product getProduct(@RequestParam(value = "id", required = true) int productId) {
		
		Product product = productDao.getById(productId);
		log.debug("Retrieving " + product);
		return product;
	}

}
