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
$(function()
{
	initializeScrollPane();
});

function showProducts(categoryId, elem) {
	$.post("showProductsByCategory.html", { 'categoryId': categoryId }, displayProducts, 'html' );
	cleanProductDetails();
	cleanSelectedCategory();
	$(elem).addClass('sectorLink-selected');	
}

function displayProducts(data) {
	$('.linea-lateral').show();
	$('#submenu-products').html(data);
	initializeScrollPane();
}

function initializeScrollPane() {
	$('.scroll-pane').jScrollPane({
		verticalDragMaxHeight: 80
	});
}

function showDetailedProduct(productId) {
	$.post("showDetailedProduct.html", { 'productId': productId }, displayProductDetails, 'html' );
	cleanSelectedProduct();
	$('#prod_' + productId).addClass('sectorLink-selected');
}

function displayProductDetails(data) {
	$('#submenu-product-show').html(data);
	$('#submenu-product-show').slideDown(1000);
}

function cleanProductDetails() {
	$('#submenu-product-show').slideUp(1000);
	cleanSelectedProduct();
}

function cleanSelectedCategory() {
	$('a').removeClass('sectorLink-selected');
	cleanSelectedProduct();
	$('.linea-lateral').hide();
}

function cleanSelectedProduct() {
	$('#submenu-products a').removeClass('sectorLink-selected');
}

function swapImgSrc(img1, img2) {
	var imgSrcAux = $('#' + img1).attr('src');
	$('#' + img1).attr('src', $('#' + img2).attr('src'));
	$('#' + img2).attr('src', imgSrcAux);
}

function showMainPicture() {
	$('#img-box').attr('src', $('#main_picture').attr('src') );
	$('#img-box-container').dialog({ 
		title: '',
		resizable: false,
		width: 400,
		modal: true,
		dialogClass: 'img-box-dialog'
	 });
}
</script>


<div style="display: none;" id="img-box-container">
	<img src="" width="232" height="297" id="img-box"/>
</div>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="tablaContenidoProductos">
			<tr>
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
						<jsp:param value="products.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				<td class="SeccionesContenidoProducto">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td class="Sector">
						<div class="scroll-pane" id="submenu-categories">
						
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SectorTabla">
							<tr>
								<td>
									<c:if test="<%= categories != null %>">
									
									<%
										for(Category category : categories) {
									%>
										<a href="#" onclick="showProducts(<%= category.getId() %>, this)" 
											class="sectorLink">
											<%= category.getLocalizedName(RequestContextUtils.getLocale(request)) %>
										</a>
										<br />
									<%
										}
									%>	
									
									</c:if>								
								</td>
							</tr>

						</table>
						</div>
						</td>
						
						<td class="linea-lateral" style="display:none;"><br/></td>
						
						<td class="Sector1">
							<div id="submenu-products"></div>
						</td>
						
						
						<td id="submenu-product-show-container">
							<div id="submenu-product-show" class="Sector2" style="display: none;"></div>
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
