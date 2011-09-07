package com.elpudu.productos.catalogo.controller.validation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.domain.Category;


@Component
public class CategoryValidator implements Validator {
	
	@Autowired
	private CategoryDao categoryDao;
	
//	public CategoryValidator(CategoryDao categoryDao) {
//		this.categoryDao = categoryDao;
//	}

	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Category.class.isAssignableFrom(clazz);
	}

	public void validate(Object target, Errors errors) {
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "field.required");
		
		if (!errors.hasFieldErrors("name")) {
			
			Category category = (Category)target;
			Category existent = categoryDao.getByName(category.getName());
			
			if (existent != null
					&& (category.getId() == null  // la catgoria es nueva (no la estoy modificando)
							|| category.getId().intValue() != existent.getId().intValue())) { // la categoria es distinta
				
				errors.rejectValue("name", "validation.exists", "already exists.");
			}
		}
		
	}

	
}
