<%@page import="com.elpudu.productos.catalogo.domain.ConfigConstants"%>
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


<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu - Sitio administrativo" name="title"/>
</jsp:include>




<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoPudu" align="center" id="productDetails-container">
			<tr>
			
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-admin.jsp">
						<jsp:param value="/admin/productList.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				<div class="relative">
				
				<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
					<tr>
						<td class="titular"><spring:message code="product.code"/></td>
						<td class="contenidoTextoInterno">${product.code}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.name"/></td>
						<td class="contenidoTextoInterno">${product.name}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.name_sv_short"/></td>
						<td class="contenidoTextoInterno">${product.name_sv}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.name_es_short"/></td>
						<td class="contenidoTextoInterno">${product.name_es}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.description"/></td>
						<td class="contenidoTextoInterno">${product.description}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.description_sv"/></td>
						<td class="contenidoTextoInterno">${product.description_sv}</td>
					</tr>
					<tr>
						<td class="titular"><spring:message code="product.description_es"/></td>
						<td class="contenidoTextoInterno">${product.description_es}</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="2"><br/></td>
					</tr>
					
					<tr class="titleRow">
						<td colspan="2">
							<spring:message code="picture" />
						</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="2"><br/></td>
					</tr>
					
					
					<tr>
						<td class="titular">
							<spring:message code="product.smallImage"/>
						</td>
						<td class="contenidoTextoInterno">

							<c:choose>
								<c:when test="${product.smallImage != null}">
									<c:url value="/imageView.html" var="url">
										<c:param name="id" value="${product.smallImage.id}" />
									</c:url>
									<img src="${url}" width="81" height="81" class="left" />
								</c:when>
								<c:otherwise>
									<div class="no-small-picture"><br/></div>
								</c:otherwise>
							</c:choose>
							
							<div class="holder">
								<div class="titular titular-nested left">
									<spring:message code="product.image"/>
								</div>
								<div class="contenidoTextoInterno">
									<c:choose>
										<c:when test="${product.id != null and product.images != null and product.imagesByOrderNumber[0] != null}">
											<c:url value="/imageView.html" var="imageUrl">
												<c:param name="id" value="${product.imagesByOrderNumber[0].id}" />
											</c:url>
											<img src="${imageUrl}" width="81" height="81" class="left" />
										</c:when>
										<c:otherwise>
											<div class="no-small-picture left"><br/></div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="2"><br/></td>
					</tr>
					
					<tr>
						<td class="titular">
							<spring:message code="product.gallery.images"/>
						</td>
						<td class="contenidoTextoInterno">
						
							<c:forEach begin="1" end="<%= ConfigConstants.MAX_IMAGE_UPLOAD - 1 %>"  varStatus="status">
								<c:choose>
									<c:when test="${product.images != null and product.imagesByOrderNumber[status.index] != null}">
										<c:url value="/imageView.html" var="imageUrl">
											<c:param name="id" value="${product.imagesByOrderNumber[status.index].id}" />
										</c:url>
										<img src="${imageUrl}" width="81" height="81" class="left double-pad-right"/>
									</c:when>
									<c:otherwise>
										<div class="no-small-picture"><br/></div>
										<div class="double-pad-right left"><br/></div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
						</td>
					</tr>

				</table>
				
					<div class="actions">
						<button onclick="window.location='productList.html'">
							<spring:message code="back" />
						</button>
					</div>

					</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
<jsp:include page="/WEB-INF/includes/footer.jsp" />
