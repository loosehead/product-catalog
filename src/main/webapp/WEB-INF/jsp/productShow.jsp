<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
<%@page import="java.util.List"%>

<%
	List<Product> products = (List<Product>)request.getAttribute("products");
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Sector2Tabla">
	<tr>
		<td class="Sector2TablaDerecha">
			<a href="#" class="Sector2Link">x</a>
		</td>
	</tr>
	
	<tr>
		<td class="Sector2FotoProducto">
			<img src='<c:url value="/imageView.html?id=${product.image.id}" />' 
				width="186" height="238" />
		</td>
	</tr>
	
	<tr>
		<td class="Sector2TablaDerecha">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="Sector2Galeria"><a href="#"><img
					src="../carga/botaGale1.png" width="21" height="21"
					border="0" /></a></td>
				<td>&nbsp;</td>
				<td class="Sector2Galeria"><a href="#"><img
					src="../carga/botaGale2.png" width="21" height="21"
					border="0" /></a></td>
				<td>&nbsp;</td>
				<td class="Sector2Galeria"><a href="#"><img
					src="../carga/botaGale3.png" width="21" height="21"
					border="0" /></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="Sector2DescripcionProd">
			<strong><spring:message code="code.abr"/>:</strong>
			${product.code}
			<br />
		
			<strong><spring:message code="name"/>:</strong> 
			${product.name}
			<br />
			
			<strong><spring:message code="detail"/>:</strong> 
			${product.description}
			
		</td>
	</tr>
</table>