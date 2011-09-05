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
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoPudu" id="productForm-container" align="center">
			<tr>
			
				<td class="SeccionesMenu">
					<br/>
				</td>
				
				
				<td class="SeccionesContenido">
				<div class="relative">

	
					<form:form method="POST" action="categoryCreate.html" id="productCreateForm"
						modelAttribute="category" commandName="category">
						
						<c:if test="${category.id != null}">
							<form:hidden path="id"/>
						</c:if>
					
						
						<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
						
						<tr class="titleRow">
							<td colspan="2">
								<spring:message code="category" />
							</td>
						</tr>
						
						<tr class="spacer">
							<td colspan="2"><br/></td>
						</tr>
					
						<tr>
							<td class="contenidoTextoInterno"><spring:message code="category.name" /></td>
							<td>
								<form:input path="name" maxlength="50" size="22" cssClass="left" /> 
								<form:errors path="name" cssClass="errors left" element="div" />
							</td>
						</tr>
						
						<tr>
							<td class="contenidoTextoInterno"><spring:message code="category.name_sv" /></td>
							<td>
								<form:input path="name_sv" maxlength="50"  size="22" cssClass="left"/> 
								<form:errors path="name_sv" cssClass="errors left" element="div" />
							</td>
						</tr>
						
						<tr>
							<td class="contenidoTextoInterno"><spring:message code="category.name_es" /></td>
							<td>
								<form:input path="name_es" maxlength="50" size="22" cssClass="left" /> 
								<form:errors path="name_es" cssClass="errors left" element="div" />
							</td>
						</tr>
						
					</table>
					
					<div class="actions">
						
						<c:choose>
							<c:when test="${category.id == null}">
								<button type="submit" name="action" value="create">
									<spring:message code="create" />
								</button>
							</c:when>
							<c:otherwise>
								<button type="submit" name="action" value="delete"
									onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.category" />')">
									<spring:message code="delete" />
								</button>
								<button type="submit" name="action" value="update">
									<spring:message code="update" />
								</button>
							</c:otherwise>
						</c:choose>
						
						<button type="submit" name="action" value="back">
							<spring:message code="cancel" />
						</button>
					</div>
				
					</form:form>

					</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
	
<jsp:include page="/WEB-INF/includes/footer.jsp" />