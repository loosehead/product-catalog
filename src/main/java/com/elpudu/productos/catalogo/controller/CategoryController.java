package com.elpudu.productos.catalogo.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;


@Controller
public class CategoryController {
	
	private static Log log = LogFactory.getLog(CategoryController.class);
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping("/admin/categoryList.html")
	@ModelAttribute("categories")
	public List<Category> getCategories() {
		return categoryDao.getAll();
	}

	@RequestMapping("/admin/categoryDetails.html")
	@ModelAttribute("category")
	public Category getCategory(@RequestParam(value = "id", required = true) int id) {
		
		Category category = categoryDao.getById(id);
		log.debug("Retrieving " + category);
		return category;
	}

}
