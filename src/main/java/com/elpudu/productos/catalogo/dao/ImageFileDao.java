package com.elpudu.productos.catalogo.dao;

import java.util.List;

import com.elpudu.productos.catalogo.domain.ImageFile;

public interface ImageFileDao {

	ImageFile create(ImageFile imageFile);

	void delete(ImageFile imageFile);

	ImageFile update(ImageFile imageFile);

	ImageFile getById(Integer id);

	List<ImageFile> getAll();

}