package com.elpudu.productos.catalogo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RedirectController {

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
		return new ModelAndView("/products");
	}
	
	@RequestMapping("/contactUs.html")
	public ModelAndView contactUs() {
		return new ModelAndView("/contactUs");
	}
}
