package com.elpudu.productos.catalogo.dao;

import java.util.List;

import com.elpudu.productos.catalogo.domain.Category;

public interface CategoryDao {

	Category create(Category category);

	void delete(Category category);

	Category update(Category category);

	/**
	 * Returns a category identified by Id, initializing its lazy attributes
	 * @param id
	 * @return
	 */
	Category getById(Integer id);

	List<Category> getAll();

	/**
	 * Retrieves a single category from a given name (deafult language).
	 * No lazy attributes are initialized
	 * @param categoryName
	 * @return
	 */
	Category getByName(String categoryName);

}