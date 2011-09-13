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
function sendAction(formId, action) {
	$('#' + formId).attr('action', action);
	$('#' + formId).submit();
}
</script>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
				
				
				<td class="SeccionesContenido">
				<div class="relative">

	
					<form:form method="POST" action="" id="categoryCreateForm"
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
								<form:input path="name" maxlength="250" size="22" cssClass="left" /> 
								<div class="required left"><br/></div>
								<form:errors path="name" cssClass="errors left" element="div" />
							</td>
						</tr>
						
						<tr>
							<td class="contenidoTextoInterno"><spring:message code="category.name_sv" /></td>
							<td>
								<form:input path="name_sv" maxlength="250"  size="22" cssClass="left"/> 
								<form:errors path="name_sv" cssClass="errors left" element="div" />
							</td>
						</tr>
						
						<tr>
							<td class="contenidoTextoInterno"><spring:message code="category.name_es" /></td>
							<td>
								<form:input path="name_es" maxlength="250" size="22" cssClass="left" /> 
								<form:errors path="name_es" cssClass="errors left" element="div" />
							</td>
						</tr>
						
						<tr>
							<td colspan="2" class="contenidoTextoInterno"><br/></td>
						</tr>
						
						<tr>
							<td colspan="2" class="contenidoTextoInterno"><br/></td>
						</tr>
						
						<tr>
							<td colspan="2" class="contenidoTextoInterno">
								<div class="required left"><br/></div>
								<spring:message code="required" />
							</td>
						</tr>
						
					</table>
					
					<div class="actions">
						
						<c:choose>
							<c:when test="${category.id == null}">
								<button type="button"" value="create" 
									onclick="sendAction('categoryCreateForm', 'createCategory.html')">
									<spring:message code="create" />
									<span class="TextoRersaltado">&gt;</span>
								</button>
							</c:when>
							<c:otherwise>
								<button type="button" value="delete"
									onclick="if (confirm('<spring:message code="are.you.sure.you.want.to.delete.this.category" />')) sendAction('categoryCreateForm', 'deleteCategory.html')">
									<spring:message code="delete" />
									<span class="TextoRersaltado">&gt;</span>
								</button>
								<button type="button" value="update"
									onclick="sendAction('categoryCreateForm', 'updateCategory.html')">
									<spring:message code="update" />
									<span class="TextoRersaltado">&gt;</span>
								</button>
							</c:otherwise>
						</c:choose>
						
						<button type="submit" value="back"
							onclick="sendAction('categoryCreateForm', 'categoryList.html')">
							<spring:message code="cancel" />
							<span class="TextoRersaltado">&gt;</span>
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