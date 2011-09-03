<%@page import="java.util.Locale"%>
<%@page import="java.util.Map"%>
<%@page import="com.elpudu.productos.catalogo.domain.ImageFile"%>
<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.elpudu.productos.catalogo.domain.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.elpudu.productos.catalogo.domain.ConfigConstants"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu - Sitio administrativo" name="title"/>
</jsp:include>


<%
	Map<Category, List<Product>> allProductsByCategory = (Map<Category, List<Product>>)request.getAttribute("allProductsByCategory");
	Locale locale = RequestContextUtils.getLocale(request);
	
	List<Product> unassigned = (List<Product>)request.getAttribute("unassigned");
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoProductos"
			id="productList-container">
			<tr>
			
				<td class="SeccionesMenu">
					<br/>
				</td>
				
				
				<td class="SeccionesContenido">
				
					<div class="actions">
						<button onclick="window.location='productFormInit.html'">
							<spring:message code="create.new.product" />
						</button>
					</div>

					
						<%
							for (Category category : allProductsByCategory.keySet()) {
						%>
						
							<div class="category-title">
								<spring:message code="category" /> <%= category.getLocalizedName(locale) %>
							</div>
						
							<table cellpadding="0" cellspacing="0" border="0" class="contenidoTexto">
							<%
								for (Product product : allProductsByCategory.get(category)) {
							%>
								<c:url value="/admin/productDetails.html" var="detailsUrl">
									<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
								</c:url>
									
								<tr class="table-cell">
									<td class="code">
										<a href="${detailsUrl}">
											<%= product.getCode() %>
										</a>
									</td>
									<td class="name">
										<a href="${detailsUrl}">
											<%= product.getLocalizedName(locale) %>
										</a>
									</td>
									<td>
										<a href="${detailsUrl}">
											<%= product.getShortLocalizedDescription(locale) %>
										</a>
									</td>
											
									<td class="actions">
										<c:url value="/admin/productFormInit.html" var="editUrl">
											<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
										</c:url>
										<a href="${editUrl}">
											<spring:message code="edit" />
										</a>
										
										<c:url value="/admin/deleteProduct.html" var="deleteUrl">
											<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
										</c:url>
										<a href="${deleteUrl}" 
											onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
											<spring:message code="delete" />
										</a>
									</td>
								</tr>
							<%
								}
							%>
							</table>
							
							<br/>
							
						<%
							}
						%>
						
						
						<c:if test="${unassigned != null and not empty unassigned}">
							<div class="category-title">
								<spring:message code="unassigned.products" /> 
							</div>
						</c:if>

						<table cellpadding="0" cellspacing="0" border="0" class="contenidoTexto">
						<%
							for (Product product : unassigned) {
						%>
							<c:url value="/admin/productDetails.html" var="detailsUrl">
								<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
							</c:url>
								
							<tr class="table-cell">
								<td class="code">
									<a href="${detailsUrl}">
										<%= product.getCode() %>
									</a>
								</td>
								<td class="name">
									<a href="${detailsUrl}">
										<%= product.getLocalizedName(locale) %>
									</a>
								</td>
								<td>
									<a href="${detailsUrl}">
										<%= product.getShortLocalizedDescription(locale) %>
									</a>
								</td>
										
								<td class="actions">
									<c:url value="/admin/productFormInit.html" var="editUrl">
										<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
									</c:url>
									<a href="${editUrl}">
										<spring:message code="edit" />
									</a>
									
									<c:url value="/admin/deleteProduct.html" var="deleteUrl">
										<c:param name="id" value="<%= String.valueOf(product.getId()) %>" />
									</c:url>
									<a href="${deleteUrl}" 
										onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
										<spring:message code="delete" />
									</a>
								</td>
							</tr>
						<%
							}
						%>
						</table>

				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	
<jsp:include page="/WEB-INF/includes/footer.jsp" />



