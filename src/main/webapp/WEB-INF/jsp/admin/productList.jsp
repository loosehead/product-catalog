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




<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoProductos"
			id="productForm-container">
			<tr>
			
				<td class="SeccionesMenu">
					<br/>
				</td>
				
				
				<td class="SeccionesContenido">
				
						<button onclick="window.location='productFormInit.html'">
							<spring:message code="create.new.product" />
						</button>

					
						<c:forEach items="${allProductsByCategory}" var="element">
						
							<div class="category-title">
								<spring:message code="category" /> ${element.key.currentLocaleName}
							</div>
						
							<table width="100%">
							<c:forEach items="${element.value}" var="product">
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
							
						</c:forEach>
						
						
						<div class="category-title">
							<spring:message code="unassigned.products" /> 
						</div>

						<table width="100%">
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



