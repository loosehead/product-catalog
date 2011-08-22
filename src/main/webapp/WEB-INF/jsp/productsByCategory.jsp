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


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SectorTabla1">

	<c:forEach items="<%= products %>" var="product">
	
		<tr>
			<td>
				<a href="#" onclick="showDetailedProduct(${product.id})" class="sectorLink">
					<img src='<c:url value="/imageView.html?id=${product.smallImage.id}" />' 
						width="81" height="81" />
				</a>
			</td>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<a href="#" onclick="showDetailedProduct(${product.id})" class="sectorLink"
								id="prod_${product.id}">
								${product.name}
							</a>
						</td>
					</tr>
					<tr>
						<td class="SectorTablaCod">${product.code}</td>
					</tr>
				</table>
			</td>
		</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	
	</c:forEach>
	
</table>