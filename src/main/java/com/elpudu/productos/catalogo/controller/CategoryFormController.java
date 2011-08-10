package com.elpudu.productos.catalogo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;

@Controller
public class CategoryFormController {
	
	@Autowired
	private CategoryDao categoryDao;

	
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
		
	
	@RequestMapping(value="/admin/categoryCreate.html")
	public ModelAndView categoryCreate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String action = request.getParameter("action");
		
		if (action.equals("create")) {
			return createCategory(request, response);
		}
		
		if (action.equals("update")) {
			return updateCategory(request, response);
		}
		
		if (action.equals("delete")) {
			return deleteCategory(request, response);
		}

		return null;
		
	}
	
	private ModelAndView deleteCategory(HttpServletRequest request,
			HttpServletResponse response) {
		
		Category category = categoryDao.getById(Integer.parseInt(request.getParameter("id")));
		categoryDao.delete(category);
		
		return new ModelAndView("redirect:categoryList.html");
	}


	private ModelAndView updateCategory(HttpServletRequest request,
			HttpServletResponse response) throws ServletRequestBindingException, IOException {
		
		Category category = categoryDao.getById(Integer.parseInt(request.getParameter("id"))); 
		category = buildCategory(category, request);
		categoryDao.update(category);

		return new ModelAndView("redirect:categoryDetails.html?id=" + category.getId());
	}


	private Category buildCategory(Category category, HttpServletRequest request) 
	throws ServletRequestBindingException, IOException {
		
		String name = ServletRequestUtils.getRequiredStringParameter(request, "name");
		String name_es = request.getParameter("name_es");
		String name_sv = request.getParameter("name_sv");
		
		category.setName(name);
		category.setName_es(name_es);
		category.setName_sv(name_sv);
		
		
		// TODO: VALIDACIONES
		
		return category;
	}


	private ModelAndView createCategory(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletRequestBindingException {
		
		Category category = buildCategory(new Category(), request);
		categoryDao.create(category);
		
		return new ModelAndView("redirect:categoryList.html");
	}



}
