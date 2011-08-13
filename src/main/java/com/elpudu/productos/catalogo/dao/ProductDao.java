package com.elpudu.productos.catalogo.dao;

import java.util.List;

import com.elpudu.productos.catalogo.domain.Product;

public interface ProductDao {

	Product create(Product product);

	void delete(Product product);

	Product update(Product product);

	/**
	 * Returns a product identified by Id, initializing its lazy attributes.
	 * Images belonging to the Product are returned in the order specified by their attribute
	 * <code>order</code>.
	 * @param id
	 * @return
	 */
	Product getById(Integer id);

	List<Product> getAll();

	Product getByCode(String code);
	
	/**
	 * Returns all products that belong to a certain category identified by id.
	 * It only initializes the products' small image.
	 * @param categoryId
	 * @return
	 */
	List<Product> getByCategoryId(Integer categoryId);

}