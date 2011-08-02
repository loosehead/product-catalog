package com.elpudu.productos.catalogo.dao;

import java.util.List;

import com.elpudu.productos.catalogo.domain.Product;

public interface ProductDao {

	Product create(Product product);

	void delete(Product product);

	Product update(Product product);

	/**
	 * Returns a product identified by Id, initializing its lazy attributes
	 * @param id
	 * @return
	 */
	Product getById(Integer id);

	List<Product> getAll();

	Product getByCode(String code);

}