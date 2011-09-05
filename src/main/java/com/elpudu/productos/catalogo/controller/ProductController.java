package com.elpudu.productos.catalogo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.Product;


@Controller
public class ProductController {
	
	private static Log log = LogFactory.getLog(ProductController.class);
	
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	

	
	@RequestMapping("/admin/productList.html")
	public ModelAndView productList(HttpServletRequest request) {
		
		Map<Category, List<Product>> allProductsByCategory = new HashMap<Category, List<Product>>();
		
		List<Category> categories = categoryDao.getAll();
		for (Category category : categories) {
			
			category.setCurrentLocaleName(category.getLocalizedName(RequestContextUtils.getLocale(request)));
			allProductsByCategory.put(category, productDao.getByCategoryId(category.getId()));
		}
		
		List<Product> unassigned = productDao.getUnassignedProducts();
		
		return new ModelAndView("/admin/productList").addObject("allProductsByCategory", allProductsByCategory)
			.addObject("unassigned", unassigned);
	}

	@RequestMapping("/admin/productDetails.html")
	@ModelAttribute("product")
	public Product getProduct(@RequestParam(value = "id", required = true) int productId) {
		
		Product product = productDao.getById(productId);
		log.debug("Retrieving " + product);
		return product;
	}
	
	@RequestMapping("/showProductsByCategory.html")
	public ModelAndView getProductsByCategory(HttpServletRequest request) throws ServletRequestBindingException {
		
		int categoryId = ServletRequestUtils.getRequiredIntParameter(request, "categoryId");
		List<Product> products = productDao.getByCategoryId(categoryId, RequestContextUtils.getLocale(request));
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("products", products);
		
		return new ModelAndView("productsByCategory", params);
	}
	
	@RequestMapping("/showDetailedProduct.html")
	public ModelAndView showDetailedProduct(
			@RequestParam(value = "productId", required = true) int productId) {
		
		Product product = productDao.getById(productId);
		return new ModelAndView("productShow", "product", product);
	}

}
