<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
		List<Product> products = (List<Product>)request.getAttribute("products");
	%>

	<button onclick="window.location='productFormInit.html'">Create</button>

<table>
	<c:forEach items="<%= products %>" var="product">
		<tr>
			<td>
				<a href='<c:url value="/admin/productDetails.html?id=${product.id}" />'>
					${product.name} 
				</a>
			</td>
			<td>
				<a href="<c:url value='/admin/productFormInit.html?id=${product.id}'/>">
					Editar
				</a>
			</td>
		</tr>
	</c:forEach>
</table>


</body>
</html>