package com.elpudu.productos.catalogo.controller.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.Product;

public class ProductValidator implements Validator {

	private ProductDao productDao;
	
	public ProductValidator(ProductDao productDao) {
		this.productDao = productDao;
	}

	private void validate(Product product, Errors errors) {

		if (!errors.hasFieldErrors("code") && product.getCode() != null) {
			
			Product existingProd = productDao.getByCode(product.getCode());
			if (existingProd != null
					&& (product.getId() == null 
							|| product.getId() != existingProd.getId())) {
				
				errors.rejectValue("code", "validation.exists", "The selected code already exists.");
			}
		}
	}

	public boolean supports(Class clazz) {
		return Product.class.isAssignableFrom(clazz);
	}

	public void validate(Object object, Errors errors) {
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "code", "field.required");
		
		this.validate((Product)object, errors);
		
	}

}
