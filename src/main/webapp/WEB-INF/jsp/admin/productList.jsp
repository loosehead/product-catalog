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
				
						<button onclick="window.location='productFormInit.html'">
							<spring:message code="create.new.product" />
						</button>

					
						<%
							for (Category category : allProductsByCategory.keySet()) {
						%>
						
							<div class="category-title">
								<spring:message code="category" /> <%= category.getLocalizedName(locale) %>
							</div>
						
							<div class="contenidoTexto">
							<%
								for (Product product : allProductsByCategory.get(category)) {
							%>
								<div class="clear h-5"><br/></div>
								<div class="left table-cell">
										<c:choose>
											<c:when test="<%= product.getSmallImage() != null %>">
												<c:url value="/imageView.html" var="url">
													<c:param name="id" value="<%= String.valueOf(product.getSmallImage().getId()) %>" />
												</c:url>
												<img src="${url}" width="81" height="81" />
											</c:when>
											<c:otherwise>
												<div class="no-small-picture"><br/></div>
											</c:otherwise>
										</c:choose>
									
										<div class="details">
											<div class="subtitle">
												<a href='<c:url value="/admin/productDetails.html?id=<%= product.getId() %>" />'>
													<%= product.getLocalizedName(locale) %>
												</a>
											</div>
											<div class="description">
												<%= product.getShortLocalizedDescription(locale) %>
											</div>
											<a href="<c:url value='/admin/productFormInit.html?id=<%= product.getId() %>'/>">
												<spring:message code="edit" />
											</a>
											<a href="#" 
												onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
												<spring:message code="delete" />
											</a>
										</div>
								</div>
								<div class="clear h-5"><br/></div>
							<%
								}
							%>
							</div>
							
							<br/>
							
						<%
							}
						%>
						
						<div class="category-title">
							<spring:message code="unassigned.products" /> 
						</div>

						<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
						<c:forEach items="${unassigned}" var="product">
							<tr>
								<td>
									<a href='<c:url value="/admin/productDetails.html?id=${product.id}" />'>
										${product.name} 
									</a>
								</td>
								<td>
									<a href="<c:url value='/admin/productFormInit.html?id=${product.id}'/>">
										<spring:message code="edit" />
									</a>
								</td>
								<td>
									<a href="#" 
										onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
										<spring:message code="delete" />
									</a>
								</td>
							</tr>
						</c:forEach>
						</table>

				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
	
<jsp:include page="/WEB-INF/includes/footer.jsp" />



