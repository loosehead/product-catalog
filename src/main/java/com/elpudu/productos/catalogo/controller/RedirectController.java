package com.elpudu.productos.catalogo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;

@Controller
public class RedirectController {
	
	@Autowired
	private CategoryDao categoryDao;

	@RequestMapping("/whoWeAre.html")
	public ModelAndView whoWeAre() {
		return new ModelAndView("/quienes");
	}
	
	@RequestMapping("/pudu.html")
	public ModelAndView pudu() {
		return new ModelAndView("/pudu");
	}
	
	@RequestMapping("/products.html")
	public ModelAndView products() {
		
		List<Category> categories = categoryDao.getAll();
		return new ModelAndView("/products", "categories", categories);
	}
	
	@RequestMapping("/contactUs.html")
	public ModelAndView contactUs() {
		return new ModelAndView("/contactUs");
	}
}
