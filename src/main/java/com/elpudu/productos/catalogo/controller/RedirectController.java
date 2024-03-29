package com.elpudu.productos.catalogo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.Contact;

@Controller
public class RedirectController {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping("/index.html")
	public ModelAndView index() {
		return new ModelAndView("/index");
	}

	@RequestMapping("/whoWeAre.html")
	public ModelAndView whoWeAre() {
		return new ModelAndView("/quienes");
	}
	
	@RequestMapping("/pudu.html")
	public ModelAndView pudu() {
		return new ModelAndView("/pudu");
	}
	
	@RequestMapping("/products.html")
	public ModelAndView products(HttpServletRequest request) {
		
		List<Category> categories = categoryDao.getAll(RequestContextUtils.getLocale(request));
		return new ModelAndView("/products", "categories", categories);
	}
	
	@RequestMapping("/contactUs.html")
	public ModelAndView contactUs() {
		return new ModelAndView("/contactUs", "contact", new Contact());
	}
	
	@RequestMapping("/admin.html")
	public ModelAndView admin() {
		return new ModelAndView("redirect:/admin/productList.html");
	}
	
	@RequestMapping(value="/errors/404.html")
    public ModelAndView handle404() {
        return new ModelAndView("/errorPage", "error-msg-code", "this.page.does.not.exist");
    }
	
	@RequestMapping(value="/errors/403.html")
    public ModelAndView handle403() {
        return new ModelAndView("/errorPage", "error-msg-code", "you.do.not.have.permissions.to.view.this.page");
    }

}
