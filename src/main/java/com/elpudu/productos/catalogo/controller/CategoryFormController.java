package com.elpudu.productos.catalogo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.elpudu.productos.catalogo.controller.validation.CategoryValidator;
import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;

@Controller
public class CategoryFormController {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private CategoryValidator categoryValidator;

	
	@RequestMapping("/admin/categoryFormInit.html")
	public ModelAndView categoryFormInit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Integer id = ServletRequestUtils.getIntParameter(request, "id");
		
		Category category = new Category();
		
		if (id != null) {
			category = categoryDao.getById(id);
		}
		
		return new ModelAndView("admin/categoryForm", "category", category);
	}
		
	
	
	@RequestMapping(value="/admin/deleteCategory.html")
	public ModelAndView deleteCategory(Category category) {
		
		category = categoryDao.getById(category.getId());
		categoryDao.delete(category);
		return new ModelAndView("redirect:categoryList.html");
	}


	@RequestMapping(value="/admin/updateCategory.html")
	public ModelAndView updateCategory(Category category,
			BindingResult result) throws ServletRequestBindingException, IOException {
		
		categoryValidator.validate(category, result);
		
		if (!result.hasErrors()) {
			categoryDao.update(category);
			return new ModelAndView("redirect:categoryList.html");
		}
		
		return new ModelAndView("/admin/categoryForm").addAllObjects(
				result.getModel());
	}

	@RequestMapping(value="/admin/createCategory.html")
	public ModelAndView createCategory(Category category,
			BindingResult result) throws IOException, ServletRequestBindingException {
		
		categoryValidator.validate(category, result);
		
		if (!result.hasErrors()) {
			categoryDao.create(category);
			return new ModelAndView("redirect:categoryList.html");
		}
		
		return new ModelAndView("/admin/categoryForm").addAllObjects(
				result.getModel());
	}



}
