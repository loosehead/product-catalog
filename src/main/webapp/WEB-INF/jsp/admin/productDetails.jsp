<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.InputStream"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<tr>
		<td><spring:message code="product.name"/></td>
		<td>${product.name}</td>
	</tr>
	<tr>
		<td><spring:message code="product.code"/></td>
		<td>${product.code}</td>
	</tr>
	<tr>
		<td><spring:message code="product.description"/></td>
		<td>${product.description}</td>
	</tr>
	
	<c:if test="${product.image != null}">
		<tr>
			<td><spring:message code="product.image"/></td>
			<td>
				<img src='<c:url value="/imageView.html?id=${product.image.id}" />' 
					width="115" border="0" />
			</td>
		</tr>
	</c:if>
</table>

</body>
</html>