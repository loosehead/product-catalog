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


<%
	Product product = (Product)request.getAttribute("product");
%>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoPudu">
			<tr>
			
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
						<jsp:param value="admin/categoryForm" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				
				
				<table>
					<tr>
						<td>
							<c:choose>
								<c:when test="<%= product.getSmallImage() != null %>">
									<c:url value="/imageView.html" var="url">
										<c:param name="id" value="<%= String.valueOf(product.getSmallImage().getId()) %>" />
									</c:url>
									<img src="${url}" width="81" height="81" class="left" />
								</c:when>
								<c:otherwise>
									<div class="no-small-picture"><br/></div>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td><spring:message code="product.name"/></td>
						<td>${product.name}</td>
					</tr>
					<tr>
						<td><spring:message code="product.name_sv"/></td>
						<td>${product.name_sv}</td>
					</tr>
					<tr>
						<td><spring:message code="product.name_es"/></td>
						<td>${product.name_es}</td>
					</tr>
					<tr>
						<td><spring:message code="product.code"/></td>
						<td>${product.code}</td>
					</tr>
					<tr>
						<td><spring:message code="product.description"/></td>
						<td>${product.description}</td>
					</tr>
					<tr>
						<td><spring:message code="product.description_sv"/></td>
						<td>${product.description_sv}</td>
					</tr>
					<tr>
						<td><spring:message code="product.description_es"/></td>
						<td>${product.description_es}</td>
					</tr>
					
					<tr>
						<td colspan="2">
						
							<c:if test="${product.images != null}">
									
								<c:forEach items="${product.images}" var="image" varStatus="count">
									<div class="left">
										<img src='<c:url value="/imageView.html?id=${image.id}" />' 
											width="115" border="0" />
									</div>
								</c:forEach>
							</c:if>
							
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
