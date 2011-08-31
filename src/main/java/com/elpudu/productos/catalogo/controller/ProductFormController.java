package com.elpudu.productos.catalogo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.elpudu.productos.catalogo.controller.validation.ProductValidator;
import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.dao.ImageFileDao;
import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.ConfigConstants;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;
import com.elpudu.productos.catalogo.domain.PuduValidationException;

@Controller
public class ProductFormController extends MultiActionController {
	
	private static Log log = LogFactory.getLog(ProductFormController.class);

	@Autowired
	private ImageFileDao imageFileDao;
	
	
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	

	@Autowired
	public ProductFormController(ProductDao productDao){
		this.productDao = productDao;
		this.setValidators(new Validator[]{new ProductValidator(productDao)});
	}
	
	
	@RequestMapping("/admin/productFormInit.html")
	public ModelAndView productFormInit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Integer id = ServletRequestUtils.getIntParameter(request, "id");
		
		Product product = new Product();
		
		if (id != null) {
			product = productDao.getById(id);
		}
		
		Map<String, Object> params = getParameterMap(product);
		
		return new ModelAndView("admin/productForm", params);
	}
		
	
	private Map<String, Object> getParameterMap(Product product) {
		
		List<Category> categories = getCategoryList();
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("product", product);
		params.put("command", product);
		params.put("categories", categories);
		
		if (product.getId() != null 
				&& (product.getCategories() == null || product.getCategories().isEmpty())) {
			params.put("warning", "this.product.does.not.belong.to.any.category");
		}
		
		return params;
	}
	
	
	private List<Category> getCategoryList() {
		
		List<Category> categories = categoryDao.getAll();
		
		Locale locale = RequestContextUtils.getLocale(
				((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest());
		
		for (Category cat : categories) {
			cat.setCurrentLocaleName(cat.getLocalizedName(locale));
		}
		
		return categories;
	}


	@RequestMapping(value="/admin/productCreate.html")
	public ModelAndView productCreate(HttpServletRequest request,
			HttpServletResponse response) 
	throws Exception {

		String action = request.getParameter("action");

		if (action == null || action.trim().equals("")) {
			action = request.getParameter("actionBt");
		}
		
		if (action.equals("create")) {
			return createProduct(request, response);
		}
		
		if (action.equals("update")) {
			return updateProduct(request, response);
		}
		
		if (action.equals("delete")) {
			return deleteProduct(request, response);
		}
		
		if (action.equals("changeSmallImage")) {
			return changeProductSmallImage(request, response);
		}
		
		if (action.equals("deleteImage")) {
			return deleteImage(request, response);
		}

		return null;
		
	}
	
	private ModelAndView deleteImage(HttpServletRequest request,
			HttpServletResponse response) throws ServletRequestBindingException {
		
		ImageFile image = imageFileDao.getById(
				ServletRequestUtils.getIntParameter(request, "imageId"));
		
		Product product = productDao.getById(ServletRequestUtils.getIntParameter(request, "id"));
		
		boolean found = false;
		Iterator<ImageFile> it = product.getImages().iterator();
		
		while (it.hasNext() && !found) {
			if (it.next().equals(image)) {
				found = true;
				it.remove();
			}
		}
		
		product = productDao.update(product);
		
		Map<String, Object> params = getParameterMap(product);
		
		return new ModelAndView("/admin/productForm", params);
	}


	private ModelAndView deleteProduct(HttpServletRequest request,
			HttpServletResponse response) {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id")));
		productDao.delete(product);
		
		return new ModelAndView("redirect:productList.html");
	}
	
	private ModelAndView changeProductSmallImage(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
//		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
//		product = buildProduct(product, request);
//		product.setSmallImage(new ImageFile());
//		
//		ServletRequestDataBinder binder = validate(request, product.getClass(), product);		
//		
//		if (!binder.getBindingResult().hasErrors()) {
//			
//			try {
//				addCategories(product, request);
//				productDao.update(product);
//				
//				Map<String, Object> params = getParameterMap(product);				
//				return new ModelAndView("/admin/productForm", params);
//				
//				
//			} catch (PuduValidationException e) {
//				return new ModelAndView("redirect:productFormInit.html?id=" + product.getId());
//			}
//			
//			
//		} else {
//			return new ModelAndView("/admin/productForm").addAllObjects(
//					binder.getBindingResult().getModel()).addObject("categories", getCategoryList());
//		}
		
		throw new IllegalAccessException("no implementado");
		
	}


	private ModelAndView updateProduct(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
		product = buildProduct(product, request);
		
		ServletRequestDataBinder binder = validate(request, product.getClass(), product);		
		
		if (!binder.getBindingResult().hasErrors()) {
			
			this.addImages(product, request);
			productDao.update(product);
			
			
			try {
				this.addCategories(product, request);
				productDao.update(product);
				
				return new ModelAndView("redirect:productList.html");
				
				
			} catch (PuduValidationException e) {
				return new ModelAndView("redirect:productFormInit.html?id=" + product.getId());
			}
			
			
		} else {
			return new ModelAndView("/admin/productForm").addAllObjects(
					binder.getBindingResult().getModel()).addObject("categories", getCategoryList())
					.addObject("product", binder.getBindingResult().getTarget());
		}

	}


	private Product buildProduct(Product product, HttpServletRequest request) 
	throws ServletRequestBindingException, IOException {
		
		String code = ServletRequestUtils.getRequiredStringParameter(request, "code");
		String name = ServletRequestUtils.getRequiredStringParameter(request, "name");
		String name_sv = request.getParameter("name_sv");
		String name_es = request.getParameter("name_es");
		String description = request.getParameter("description");
		String description_sv = request.getParameter("description_sv");
		String description_es = request.getParameter("description_es");
		
		product.setCode(code);
		product.setName(name);
		product.setName_sv(name_sv);
		product.setName_es(name_es);
		product.setDescription(description);
		product.setDescription_sv(description_sv);
		product.setDescription_es(description_es);
		
		return product;
	}
	
	private void addImages(Product product, HttpServletRequest request) 
	throws ServletRequestBindingException, IOException {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		for (int index = 0; index < ConfigConstants.MAX_IMAGE_UPLOAD; index++) {
			
			ImageFile imageFile = buildImageFile(multipartRequest, "imageFile", index);
			if (imageFile != null) {

				ImageFile deletedImg = product.removeImageByOrderNumber(index);
				if (deletedImg != null) {
					imageFileDao.delete(deletedImg);
				}
				
				product.addImage(imageFile);
			}
		}
		
		ImageFile smallImage = buildImageFile(multipartRequest, "smallImageFile", null);
		if (smallImage != null) {
			
			if (product.getSmallImage() != null) {
				productDao.deleteSmallImage(product);
			}
			
			product.setSmallImage(smallImage);
		}
	}
	
	private void addCategories(Product product, ServletRequest request) 
	throws ServletRequestBindingException, PuduValidationException {
		
		// first we process the selection of categories
		
		String categoryIdsStr = ServletRequestUtils.getStringParameter(request, "param_categories");
		
		
		if (product.getCategories() != null) {
			product.getCategories().clear();
		}
		
		if (categoryIdsStr != null) {
			for (String categoryIdStr : categoryIdsStr.split(",")) {
				
				if (categoryIdStr != null && !categoryIdStr.trim().equals("")) {
					Category category = categoryDao.getById(Integer.parseInt(categoryIdStr));
					product.addCategory(category);
				}
			}
		}
		
		// now we process any new categories
		
		String categoryName = ServletRequestUtils.getStringParameter(request, "param_category_name");
		String categoryName_es = ServletRequestUtils.getStringParameter(request, "param_category_name_es");
		String categoryName_sv = ServletRequestUtils.getStringParameter(request, "param_category_name_sv");
		
		if (categoryName != null && !categoryName.trim().equals("")) {
			
			Category newCategory = null;
			Category existentCategory = categoryDao.getByName(categoryName);
			
			if (existentCategory != null) {
				newCategory = existentCategory;
				
			} else {
				newCategory = new Category();
				newCategory.setName(categoryName);
				newCategory.setName_es(categoryName_es);
				newCategory.setName_sv(categoryName_sv);
				
				newCategory = categoryDao.create(newCategory);
			}
			
			product.addCategory(newCategory);
		}
		
		if (product.getCategories() == null || product.getCategories().isEmpty()) {
			throw new PuduValidationException();
		}
	}


	private ImageFile buildImageFile(MultipartHttpServletRequest multipartRequest, 
			String paramName, Integer index) throws IOException {
		
		ImageFile imageFile = null;
		
		if (index != null) {
			paramName = paramName + "_" + index;
		}
		
		MultipartFile multipartFile = multipartRequest.getFile(paramName);
		
		if (multipartFile != null && multipartFile.getOriginalFilename() != null 
				&& !multipartFile.getOriginalFilename().trim().equals("")) {
			
			imageFile = new ImageFile();
			imageFile.setFileName(multipartFile.getOriginalFilename());
			imageFile.setType(multipartFile.getContentType());
			imageFile.setContent(multipartFile.getBytes());
			
			imageFile.setOrderNumber(index);
		
		}
		
		return imageFile;
	}
	



	private ModelAndView createProduct(HttpServletRequest request,
			HttpServletResponse response) 
	throws Exception {
		
		Product product = buildProduct(new Product(), request);
		
		ServletRequestDataBinder binder = validate(request, product.getClass(), product);		
		
		if (!binder.getBindingResult().hasErrors()) {
			
			productDao.create(product);
			
			this.addImages(product, request);
			productDao.update(product);
			
			try {
				addCategories(product, request);
				productDao.update(product);
				
			} catch (PuduValidationException e) {
				return new ModelAndView("redirect:productFormInit.html?id=" + product.getId());
			}
			
			return new ModelAndView("redirect:productList.html");
			
		} else {
			
			return new ModelAndView("/admin/productForm").addAllObjects(
					binder.getBindingResult().getModel()).addObject("categories", getCategoryList());
		}
		
	}



	@SuppressWarnings("rawtypes")
	private ServletRequestDataBinder validate(HttpServletRequest request, Class clazz, Object object) 
	throws Exception {
		
		ServletRequestDataBinder binder = createBinder(request, object);
		binder.bind(request);
		
		if (this.getValidators() != null) {
		    for (Validator val : this.getValidators()) {
		        if (val != null && val.supports(clazz)) {
		        	ValidationUtils.invokeValidator(val, object, binder.getBindingResult());
		        }
		    }
		}
		
		return binder;
		
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
