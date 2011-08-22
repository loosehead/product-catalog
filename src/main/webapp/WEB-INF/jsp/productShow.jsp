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
			<a href="#" class="Sector2Link" onclick="cleanProductDetails()">x</a>
		</td>
	</tr>
	
	<tr>
		<td class="Sector2FotoProducto">
		
			<c:forEach items="${product.images}" var="image" varStatus="counter">
				<c:if test="${counter.count eq 1}">
					<img src='<c:url value="/imageView.html?id=${image.id}" />' 
						width="186" height="238" id="main_picture"/>
				</c:if>
			</c:forEach>
		</td>
	</tr>
	
	<tr>
		<td class="Sector2TablaDerecha">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<c:forEach items="${product.images}" var="image" varStatus="counter">
				
					<c:if test="${counter.count gt 1}">
						<td class="Sector2Galeria">
							<a href="#" onclick="swapImgSrc('picture_${counter.count}','main_picture')">
								<img src='<c:url value="/imageView.html?id=${image.id}" />' 
									width="21" height="21" border="0" 
									id="picture_${counter.count}"/>
							</a>
						</td>
						<td>&nbsp;</td>
					</c:if>
					
				</c:forEach>
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