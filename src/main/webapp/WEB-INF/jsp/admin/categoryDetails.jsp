<%@page import="com.elpudu.productos.catalogo.domain.Category"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu - Sitio administrativo" name="title"/>
</jsp:include>




<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoPudu">
			<tr>
			
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
						<jsp:param value="admin/categoryList" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				
					<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
					
						<tr>
							<td><spring:message code="category.name"/></td>
							<td>${category.name}</td>
						</tr>
						<tr>
							<td><spring:message code="category.name_sv"/></td>
							<td>${category.name_sv}</td>
						</tr>
						<tr>
							<td><spring:message code="category.name_es"/></td>
							<td>${category.name_es}</td>
						</tr>

					</table>
					
				</td>
			</tr>
			</table>
			
		</td>
	</tr>
</table>

<jsp:include page="/WEB-INF/includes/footer.jsp" />
