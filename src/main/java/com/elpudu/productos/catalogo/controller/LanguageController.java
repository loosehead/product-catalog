package com.elpudu.productos.catalogo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

@Controller
public class LanguageController extends AbstractController {
	
	private static Log log = LogFactory.getLog(LanguageController.class);
	

	@Override
	@RequestMapping("/languageSet.html")
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		return new ModelAndView("/quienes");
	}

}
