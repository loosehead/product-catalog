<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
<%@page import="java.util.List"%>

<%
	List<Product> products = (List<Product>)request.getAttribute("products");
%>

<div class="scroll-pane">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SectorTabla1">

	<%
		for (Product product : products) {
	%>
	
		<tr>
			<td>
				<a href="#" onclick="showDetailedProduct(<%= product.getId() %>)" class="sectorLink">
				<c:if test="<%= product.getSmallImage() != null %>">
					<c:url value="imageView.html" var="url">
						<c:param name="id" value="<%= String.valueOf(product.getSmallImage().getId()) %>" />
					</c:url>
					<img src="${url}" width="81" height="81" />
				</c:if>
				</a>
			</td>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<a href="#" onclick="showDetailedProduct(<%= product.getId() %>)" 
								class="sectorLink" id="prod_<%= product.getId() %>">
								<%= product.getLocalizedName(RequestContextUtils.getLocale(request)) %>
							</a>
						</td>
					</tr>
					<tr>
						<td class="SectorTablaCod"><%= product.getCode() %></td>
					</tr>
				</table>
			</td>
		</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	
	<%
		}
	%>
	
</table>
</div>