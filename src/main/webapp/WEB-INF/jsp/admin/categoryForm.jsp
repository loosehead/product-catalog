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
						<jsp:param value="admin/categoryForm" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">

				<h1><spring:message code="create.category.title"></spring:message></h1>
	
					<form:form method="POST" action="categoryCreate.html"  
						modelAttribute="category" commandName="category">
						
						<c:if test="${category.id != null}">
							<form:hidden path="id"/>
						</c:if>
					
						
						<table>
						<tr>
							<td><spring:message code="category.name" /></td>
							<td>
								<form:input path="name" maxlength="50" /> 
								<form:errors path="name" cssClass="errors" />
							</td>
						</tr>
						
						<tr>
							<td><spring:message code="category.name_sv" /></td>
							<td>
								<form:input path="name_sv" maxlength="50" /> 
								<form:errors path="name_sv" cssClass="errors" />
							</td>
						</tr>
						
						<tr>
							<td><spring:message code="category.name_es" /></td>
							<td>
								<form:input path="name_es" maxlength="50" /> 
								<form:errors path="name_es" cssClass="errors" />
							</td>
						</tr>
						
					
						<tr>
							<td>
								<c:choose>
									<c:when test="${category.id == null}">
										<button type="submit" name="action" value="create">
											<spring:message code="create" />
										</button>
									</c:when>
									<c:otherwise>
										<button type="submit" name="action" value="delete"
											onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.category" />')">
											Delete
										</button>
										<button type="submit" name="action" value="update">
											<spring:message code="update" />
										</button>
									</c:otherwise>
								</c:choose>
				
							</td>
							<td></td>
						</tr>
					
					</table>
					</form:form>

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
<jsp:include page="/WEB-INF/includes/footer.jsp" />