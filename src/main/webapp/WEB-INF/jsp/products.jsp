<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.elpudu.productos.catalogo.domain.Category"%>
<%@page import="java.util.List"%>


<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu" name="title"/>
</jsp:include>


<%
	List<Category> categories = (List<Category>)request.getAttribute("categories");
%>


<script type="text/javascript">
function showProducts(categoryId) {
	$('#submenu-product-show').html('');
	$.post("showProductsByCategory.html", { 'categoryId': categoryId }, displayProducts, 'html' );
}

function displayProducts(data) {
	$('#submenu-products').html(data);
}

function showDetailedProduct(productId) {
	$.post("showDetailedProduct.html", { 'productId': productId }, displayProductDetails, 'html' );
}

function displayProductDetails(data) {
	$('#submenu-product-show').html(data);
}

function swapImgSrc(img1, img2) {
	var imgSrcAux = $('#' + img1).attr('src');
	$('#' + img1).attr('src', $('#' + img2).attr('src'));
	$('#' + img2).attr('src', imgSrcAux);
}
</script>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoProductos">
			<tr>
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
						<jsp:param value="products" name="pageFrom"/>
					</jsp:include>
				</td>
				
				<td class="SeccionesContenidoProducto">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="Sector">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SectorTabla">
							<tr>
								<td>
									<c:if test="<%= categories != null %>">
									
									<%
										for(Category category : categories) {
									%>
										<a href="#" onclick="showProducts(<%= category.getId() %>)" 
											class="sectorLink">
											<c:choose>
												<c:when test='<%= RequestContextUtils.getLocale(
													request).getLanguage().equals("sv") 
													&& category.getName_sv() != null %>'>
													<%= category.getName_sv() %>
												</c:when>
												
												<c:when test='<%= RequestContextUtils.getLocale(
													request).getLanguage().equals("es") 
													&& category.getName_es() != null %>'>
													<%= category.getName_es() %>
												</c:when>
												
												<c:otherwise>
													<%= category.getName() %>
												</c:otherwise>
											</c:choose>
										</a>
										<br />
									<%
										}
									%>	
									
									</c:if>								
								</td>
							</tr>

						</table>
						</td>
						
						
						<td class="Sector1">
							<div id="submenu-products">
							
							</div>
						</td>
						
						
						<td class="Sector2">
							<div id="submenu-product-show">
						
							</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<jsp:include page="/WEB-INF/includes/footer.jsp" />
