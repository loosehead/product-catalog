package com.elpudu.productos.catalogo.domain;

public class PuduValidationException extends Exception {

	private static final long serialVersionUID = -2489916700484268693L;

	public PuduValidationException() {
	}

	public PuduValidationException(String message) {
		super(message);
	}

	public PuduValidationException(Throwable cause) {
		super(cause);
	}

	public PuduValidationException(String message, Throwable cause) {
		super(message, cause);
	}

}
