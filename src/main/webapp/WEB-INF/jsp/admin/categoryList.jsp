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

<script type="text/javascript">
$(function() {
	initializeScrollPane();
});

function initializeScrollPane() {
	$('.scroll-pane-admin').jScrollPane({
		verticalDragMaxHeight: 80
	});
}
</script>

	<%
		List<Category> categories = (List<Category>)request.getAttribute("categories");
	%>

	
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="category-list-container">
	<tr>
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoPudu" align="center">
			<tr>
			
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-admin.jsp">
						<jsp:param value="/admin/categoryList.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido" id="productList-container">
				
					<div class="actions">
						<button onclick="window.location='categoryFormInit.html'">
							<spring:message code="create.new.category" />
						</button>
					</div>
					<div class="scroll-pane-admin">
				
					<table cellpadding="0" cellspacing="0" border="0" class="contenidoTexto">
					
					<tr>
						<th><spring:message code="category.name" /></th>
						<th><spring:message code="category.name_sv" /></th>
						<th><spring:message code="category.name_es" /></th>
						<th><br/></th>
					</tr>
				

					<c:forEach items="<%= categories %>" var="category">
						<tr class="table-cell">
							<td>
								${category.name} 
							</td>
							<td>
								${category.name_sv} 
							</td>
							<td>
								${category.name_es} 
							</td>
							<td class="actions">
								<c:url value="/admin/categoryFormInit.html" var="editUrl">
									<c:param name="id" value="${category.id}" />
								</c:url>
								<a href="${editUrl}">
									<spring:message code="edit" />
								</a>
								
								<c:url value="/admin/deleteCategory.html" var="deleteUrl">
									<c:param name="id" value="${category.id}" />
								</c:url>
								<a href="${deleteUrl}" 
									onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.category" />')">
									<spring:message code="delete" />
								</a>
							</td>
						</tr>
					</c:forEach>
					
					</table>
					
				</div>
				</td>
				
			</tr>
		</table>
		</td>
	</tr>
</table>


<jsp:include page="/WEB-INF/includes/footer.jsp" />
