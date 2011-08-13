<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.elpudu.productos.catalogo.domain.ConfigConstants"%>

<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu - Sitio administrativo" name="title"/>
</jsp:include>


<script type="text/javascript">
	function sendImageAction(formId, action, imageId) {
		$('#actionParam').val(action);
		$('#imageIdParam').val(imageId);
		$('#' + formId).submit();
	}

	function show(elemId) {
		$('#' + elemId).show();
	}
</script>



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



				<h1><spring:message code="create.product.title"></spring:message></h1>
				
				<form:form method="POST" action="productCreate.html" id="productCreateForm"
					enctype="multipart/form-data" modelAttribute="product" commandName="product">
					
					<c:if test="${product.id != null}">
						<form:hidden path="id"/>
					</c:if>
				
					<input type="hidden" name="action" value="" id="actionParam" />
					<input type="hidden" name="imageId" value="" id="imageIdParam" />
					
					<table>
					<tr>
						<td><spring:message code="product.name" /></td>
						<td>
							<form:input path="name" maxlength="50" /> 
							<form:errors path="name" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.name_sv" /></td>
						<td>
							<form:input path="name_sv" maxlength="50" /> 
							<form:errors path="name_sv" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.name_es" /></td>
						<td>
							<form:input path="name_es" maxlength="50" /> 
							<form:errors path="name_es" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.code" /></td>
						<td>
							<form:input path="code" maxlength="10" /> 
							<form:errors path="code" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.description" /></td>
						<td>
							<form:textarea path="description" rows="5" /> 
							<form:errors path="description" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.description_sv" /></td>
						<td>
							<form:textarea path="description_sv" rows="5" /> 
							<form:errors path="description_sv" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.description_es" /></td>
						<td>
							<form:textarea path="description_es" rows="5" /> 
							<form:errors path="description_es" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.smallImage" /></td>
						<td>
							<c:choose>
								<c:when test="${product.id == null or (product.smallImage != null and product.smallImage.id == null)}">
									<input type="file" name="smallImageFile"/>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${product.smallImage != null}">
											<img src='<c:url value="/imageView.html?id=${product.smallImage.id}" />' 
												width="115" border="0" />
											<div>
												<button type="submit" name="actionBt" value="changeSmallImage">
													<spring:message code="change" />
												</button>
											</div>
										</c:when>
										<c:otherwise>
											<div>
												<button type="submit" name="actionBt" value="changeSmallImage">
													<spring:message code="add" />
												</button>
											</div>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.image" /></td>
						<td>
							<c:if test="${product.id != null and product.images != null}">
							
								<c:forEach items="${product.images}" var="image" varStatus="count">
									<div class="left">
										<img src='<c:url value="/imageView.html?id=${image.id}" />' 
											width="115" border="0" />
										<a href="#" 
											onclick="if (confirm('<spring:message code="are.you.sure.you.want.to.delete.this.picture" />')) sendImageAction('productCreateForm','deleteImage', ${image.id})">
											<spring:message code="delete" />
										</a>
									</div>
								</c:forEach>
							</c:if>
								
							<%
								for (int i = 0; i < ConfigConstants.MAX_IMAGE_UPLOAD; i++) {
							%>
								<div style='<%= i > 0 ? "display: none;" : "" %>' id="newImage_<%= i %>">
									<input type="file" name="imageFile_<%= i %>"/>
									<input type="text" name="imageFileOrder_<%= i %>"/>
									<% if (i < ConfigConstants.MAX_IMAGE_UPLOAD - 1) { %>
									<a href="#" onclick="show('newImage_<%= i + 1 %>')">
										<spring:message code="add" />
									</a>
									<% } %>
								</div>
							<%
								}
							%>
							
						</td>
					</tr>
					
					<tr>
						<td><spring:message code="product.categories" /></td>
						<td>
							<form:checkboxes items="${categories}" path="categories" 
								delimiter="<br/>" itemLabel="name" itemValue="id"/>
						</td>
					</tr>
				
					<tr>
						<td>
							<c:choose>
								<c:when test="${product.id == null}">
									<button type="submit" name="actionBt" value="create">
										<spring:message code="create" />
									</button>
								</c:when>
								<c:otherwise>
									<button type="submit" name="actionBt" value="delete"
										onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
										<spring:message code="delete" />
									</button>
									<button type="submit" name="actionBt" value="update">
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