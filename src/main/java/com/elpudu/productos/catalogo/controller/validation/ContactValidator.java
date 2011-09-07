package com.elpudu.productos.catalogo.controller.validation;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.elpudu.productos.catalogo.domain.Contact;

public class ContactValidator implements Validator {
	
	@SuppressWarnings("rawtypes")
	public boolean supports(Class clazz) {
		return Contact.class.isAssignableFrom(clazz);
	}

	public void validate(Object target, Errors errors) {
		
		Contact contact = (Contact)target;
		if (!errors.hasFieldErrors("email") && contact.getEmail() != null) {
			
			if (!contact.getEmail().contains("@")) {
				errors.rejectValue("email", "invalid.email.address");
			}
		}
		
		if (contact.getComment() != null) {
			if (contact.getComment().length() > 1000) {
				errors.rejectValue("comment", "exceeds.max.characters", new Object[]{1000}, "too long.");
			}
		}
		
	}

}
