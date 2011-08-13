package com.elpudu.productos.catalogo.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.Validator;
import org.springframework.web.bind.ServletRequestBindingException;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.elpudu.productos.catalogo.controller.validation.ProductValidator;
import com.elpudu.productos.catalogo.dao.CategoryDao;
import com.elpudu.productos.catalogo.dao.ImageFileDao;
import com.elpudu.productos.catalogo.dao.ProductDao;
import com.elpudu.productos.catalogo.domain.Category;
import com.elpudu.productos.catalogo.domain.ConfigConstants;
import com.elpudu.productos.catalogo.domain.ImageFile;
import com.elpudu.productos.catalogo.domain.Product;

@Controller
public class ProductFormController extends MultiActionController {
	
	private static Log log = LogFactory.getLog(ProductFormController.class);

	@Autowired
	private ImageFileDao imageFileDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
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
		
		List<Category> categories = categoryDao.getAll();
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("product", product);
		params.put("categories", categories);
		
		return params;
	}


	@RequestMapping(value="/admin/productCreate.html")
	public ModelAndView productCreate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
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
			HttpServletResponse response) throws ServletRequestBindingException, IOException {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
		
		// to avoid losing other changes the user may have made
		product = buildProduct(product, request);
		addCategories(product, request);
		
		product.setSmallImage(new ImageFile());
		
		Map<String, Object> params = getParameterMap(product);
		
		return new ModelAndView("/admin/productForm", params);
	}


	private ModelAndView updateProduct(HttpServletRequest request,
			HttpServletResponse response) throws ServletRequestBindingException, IOException {
		
		Product product = productDao.getById(Integer.parseInt(request.getParameter("id"))); 
		product = buildProduct(product, request);
		addCategories(product, request);
		productDao.update(product);

		return new ModelAndView("redirect:productDetails.html?id=" + product.getId());
	}


	private Product buildProduct(Product product, HttpServletRequest request) 
	throws ServletRequestBindingException, IOException {
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		
		for (int index = 0; index < ConfigConstants.MAX_IMAGE_UPLOAD; index++) {
			ImageFile imageFile = buildImageFile(multipartRequest, "imageFile", index);
			if (imageFile != null) {
				product.addImage(imageFile);
			}
		}
		
		
		ImageFile smallImage = buildImageFile(multipartRequest, "smallImageFile", null);
		if (smallImage != null) {
			product.setSmallImage(smallImage);
		}

		
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
		
		
		// TODO: VALIDACIONES
		
		return product;
	}
	
	private void addCategories(Product product, ServletRequest request) {
		
		int[] categoryIds = ServletRequestUtils.getIntParameters(request, "categories");
		
		
		if (product.getCategories() != null) {
			product.getCategories().clear();
		}
		
		if (categoryIds != null) {
			for (int categoryId : categoryIds) {
				
				Category category = categoryDao.getById(categoryId);
				product.addCategory(category);
			}
		}
		
		// TODO: VALIDACIONES
	}


	private ImageFile buildImageFile(MultipartHttpServletRequest multipartRequest, 
			String paramName, Integer index) throws IOException {
		
		ImageFile imageFile = null;
		
		String orderParam = paramName + "Order";
		
		if (index != null) {
			paramName = paramName + "_" + index;
			orderParam = orderParam + "_" + index;
		}
		
		MultipartFile multipartFile = multipartRequest.getFile(paramName);
		
		if (multipartFile != null && multipartFile.getOriginalFilename() != null 
				&& !multipartFile.getOriginalFilename().trim().equals("")) {
			
			imageFile = new ImageFile();
			imageFile.setFileName(multipartFile.getOriginalFilename());
			imageFile.setType(multipartFile.getContentType());
			imageFile.setContent(multipartFile.getBytes());
			
			String orderStr = multipartRequest.getParameter(orderParam);
			if (orderStr != null && !orderStr.trim().equals("")) {
				try {
					int orderNumber = Integer.parseInt(orderStr);
					imageFile.setOrderNumber(orderNumber);
					
				} catch (Exception e) {
					log.error("No puede convertirse el string " + orderStr + " a un numero entero.");
				}
			}
			
			// to avoid pictures with null order coming first
			if (imageFile.getOrderNumber() == null) {
				imageFile.setOrderNumber(ConfigConstants.MAX_ORDER);
			}
		}
		
		return imageFile;
	}


	private ModelAndView createProduct(HttpServletRequest request,
			HttpServletResponse response) throws IOException, ServletRequestBindingException {
		
		Product product = buildProduct(new Product(), request);
		productDao.create(product);
		
		addCategories(product, request);
		productDao.update(product);
		
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
