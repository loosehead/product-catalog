package com.elpudu.productos.catalogo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.DataBinder;
import org.springframework.validation.Validator;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.elpudu.productos.catalogo.controller.validation.ProductValidator;
import com.elpudu.productos.catalogo.dao.ImageFileDao;
import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;

@Controller
public class ProductFormController extends MultiActionController {

	@Autowired
	private ImageFileDao imageFileDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private ProductValidator productValidator;
	
//	@Override
//	@InitBinder
//	protected void initBinder(HttpServletRequest request,
//			ServletRequestDataBinder binder) throws Exception {
//
//		super.initBinder(request, binder);
//		binder.registerCustomEditor(String.class, new StringTrimmerEditor(false));
//		binder.setRequiredFields(new String[]{"code", "name"});
//	}
	
	public ProductFormController(){
		this.setValidators(new Validator[]{productValidator});
	}
	
	
	@RequestMapping("/productFormInit.html")
	public ModelAndView productFormInit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Integer id = ServletRequestUtils.getIntParameter(request, "id");
		
		Product product = new Product();
		
		if (id != null) {
			product = productDao.getById(id);
		}
		
		return new ModelAndView("productForm", "product", product);
	}
		
	
	@RequestMapping(value="/productCreate.html")
	public ModelAndView productCreate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String action = request.getParameter("action");
		
		if (action.equals("create")) {
			return createProduct(request, response);
		}
		
		if (action.equals("update")) {
			return updateProduct(request, response);
		}
		
		if (action.equals("delete")) {
			return deleteProduct(request, response);
		}
		
		if (action.equals("changeImage")) {
			return changeProductImage(request, response);
		}

		return null;
		
	}
	
	private ModelAndView deleteProduct(HttpServletRequest request,
			HttpServletResponse response) {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id")));
		productDao.delete(product);
		
		return new ModelAndView("redirect:productList.html");
	}


	private ModelAndView changeProductImage(HttpServletRequest request,
			HttpServletResponse response) throws ServletRequestBindingException, IOException {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
		product = buildProduct(product, request);
		product.setImage(new ImageFile());
		
		return new ModelAndView("productForm", "product", product);
	}


	private ModelAndView updateProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletRequestBindingException, IOException {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
		product = buildProduct(product, request);
		productDao.update(product);

		return new ModelAndView("redirect:productDetails.html?id=" + product.getId());
	}


	private Product buildProduct(Product product, HttpServletRequest request) 
	throws ServletRequestBindingException, IOException {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile multipartFile = multipartRequest.getFile("imageFile");
		
		if (multipartFile != null && multipartFile.getOriginalFilename() != null 
				&& !multipartFile.getOriginalFilename().trim().equals("")) {
			
			ImageFile imageFile = new ImageFile();
			imageFile.setFileName(multipartFile.getOriginalFilename());
			imageFile.setType(multipartFile.getContentType());
			imageFile.setContent(multipartFile.getBytes());
			product.setImage(imageFile);
		}
		
		String code = ServletRequestUtils.getRequiredStringParameter(request, "code");
		String name = ServletRequestUtils.getRequiredStringParameter(request, "name");
		String description = request.getParameter("description");
		
		product.setCode(code);
		product.setName(name);
		product.setDescription(description);
		
		
		// TODO: VALIDACIONES
		
		return product;
	}


	private ModelAndView createProduct(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletRequestBindingException {
		
		Product product = buildProduct(new Product(), request);
		productDao.create(product);
		
		return new ModelAndView("redirect:productList.html");
	}



	@RequestMapping("/imageView.html")
	public ModelAndView imageView(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		int id = ServletRequestUtils.getRequiredIntParameter(request, "id");

		ImageFile image = imageFileDao.getById(id);

		response.setContentType(image.getType());
		response.setContentLength(image.getContent().length);
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ image.getFileName() + "\"");

		FileCopyUtils.copy(image.getContent(), response.getOutputStream());

		return null;

	}



}
