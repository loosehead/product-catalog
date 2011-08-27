<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="java.util.List"%>
<%@page import="com.elpudu.productos.catalogo.domain.Category"%>
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

	function openNewCategory() {
		$('#newCategory').dialog({ 
			title: '<spring:message code="enter.new.category" />',
			resizable: false,
			width: 300,
			position: [415,110]
		 });
	}

	function openSelectCategory() {
		$('#selectCategory').dialog({ 
			title: '<spring:message code="category.selection" />',
			resizable: false,
			width: 300,
			position: [535,110]
		 });
	}

	function closeDialog(dialogId) {
		$('#' + dialogId).dialog("close");
	}

	function acceptNewCategory() {

		closeDialog('newCategory');
		
		// set default values
		if ( $('#category_name').val() == '') {
			if ( $('#category_name_es').val() == '') {
				if ( $('#category_name_sv').val() != '' ) {
					$('#category_name').val( $('#category_name_sv').val() );
				}
			} else {
				$('#category_name').val( $('#category_name_es').val() );
			}
		}

		if ( $('#category_name_es').val() == '') {
			if ( $('#category_name').val() == '') {
				if ( $('#category_name_sv').val() != '' ) {
					$('#category_name_es').val( $('#category_name_sv').val() );
				}
			} else {
				$('#category_name_es').val( $('#category_name').val() );
			}
		}

		if ( $('#category_name_sv').val() == '') {
			if ( $('#category_name').val() == '') {
				if ( $('#category_name_es').val() != '' ) {
					$('#category_name_sv').val( $('#category_name_es').val() );
				}
			} else {
				$('#category_name_sv').val( $('#category_name').val() );
			}
		}

		// take dafault
		var defaultValue = $('#category_name').val();
		if ( $('#category_name_es').hasClass('default') ) {
			defaultValue = $('#category_name_es').val();
		}
		if ( $('#category_name_sv').hasClass('default') ) {
			defaultValue = $('#category_name_sv').val();
		}

		if (defaultValue != '') {
			$('#new_category_holder').html(defaultValue);
		}
		
	}

	function copyParameters() {
		$('#param_category_name').val( $('#category_name').val() );
		$('#param_category_name_es').val( $('#category_name_es').val() );
		$('#param_category_name_sv').val( $('#category_name_sv').val() );

		var selectedCategories = '';
		$('input:checked').each(function(index) {
			if (index > 0) {
				selectedCategories = selectedCategories + ',';
			}
			selectedCategories = selectedCategories + $(this).val();
		  });

		$('#param_categories').val(selectedCategories);
	}
		
</script>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoProductos">
			<tr>
			
				<td class="SeccionesMenu">
					<br/>
				</td>
				
				
				<td class="SeccionesContenido">


				<form:form method="POST" action="productCreate.html" id="productCreateForm"
					enctype="multipart/form-data" modelAttribute="product" commandName="product"
					onsubmit="copyParameters()">
					
					<c:if test="${product.id != null}">
						<form:hidden path="id"/>
					</c:if>
				
					<input type="hidden" name="action" value="" id="actionParam" />
					<input type="hidden" name="imageId" value="" id="imageIdParam" />
					
					<input type="hidden" name="param_category_name" value="" id="param_category_name" />
					<input type="hidden" name="param_category_name_sv" value="" id="param_category_name_sv" />
					<input type="hidden" name="param_category_name_es" value="" id="param_category_name_es" />
					<input type="hidden" name="param_categories" value="" id="param_categories" />
					
					
					<div id="selectCategory" style="display: none;">
						<div class="inner-title">
							<spring:message code="please.select.the.product.categories" />
						</div>
							
						<form:checkboxes items="${categories}" path="categories" cssClass="categories"
								delimiter="<br/>"  itemValue="id" itemLabel="currentLocaleName"/>
					</div>
					
					
					<div id="newCategory" style="display: none;">
						<div class="inner-title">
							<spring:message code="please.enter.a.new.category" />
						</div>
						<jsp:include page="/WEB-INF/jsp/admin/categoryFormPopUp.jsp"></jsp:include>
					</div>
					
					
					
					<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto" 
						style="padding-left: 100px;">
					
					<tr class="titleRow">
						<td colspan="4">
							<spring:message code="category" />
						</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="new.category" />
						</td>
						<td>
							<div class="input-link" id="new_category_holder" onclick="openNewCategory()">
								<spring:message code="insert" />
							</div>
						</td>
						
						<td class="contenidoTextoInterno">
							<div class="right pad-right">
								<spring:message code="existent.category" />
							</div>
						</td>
						<td>
							<div class="input-link" id="existent_category_holder" onclick="openSelectCategory()">
								<spring:message code="select" />
							</div>
						</td>
					</tr>
					
					
					<tr class="divider">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr class="spacer">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr class="titleRow">
						<td colspan="4">
							<spring:message code="product" />
						</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.name" />
						</td>
						<td>
							<form:input path="name" maxlength="50" size="22" /> 
							<form:errors path="name" cssClass="errors" />
						</td>
						
						<td class="contenidoTextoInterno">
							<div class="right pad-right">
								<spring:message code="product.code" />
							</div>
						</td>
						<td>
							<form:input path="code" maxlength="10" size="10" cssClass="left" /> 
							<form:errors path="code" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.name_sv" />
						</td>
						<td>
							<form:input path="name_sv" maxlength="50" size="22" /> 
							<form:errors path="name_sv" cssClass="errors" />
							<div class="right" style="width: 20px;"><br/></div>
						</td>
						
						<td class="contenidoTextoInterno">
							<div class="right pad-right">
								<spring:message code="product.name_es" />
							</div>
						</td>
						<td>
							<form:input path="name_es" maxlength="50" size="22" /> 
							<form:errors path="name_es" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description" />
						</td>
						<td colspan="3">
							<form:textarea path="description" rows="1" cols="66" cssClass="left" /> 
							<form:errors path="description" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description_sv" />
						</td>
						<td colspan="3">
							<form:textarea path="description_sv" rows="1" cols="66" cssClass="left"  /> 
							<form:errors path="description_sv" cssClass="errors" />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description_es" />
						</td>
						<td colspan="3">
							<form:textarea path="description_es" rows="1" cols="66" cssClass="left" /> 
							<form:errors path="description_es" cssClass="errors" />
						</td>
					</tr>
					
					<tr class="divider">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr class="spacer">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr class="titleRow">
						<td colspan="4">
							<spring:message code="picture" />
						</td>
					</tr>
					
					<tr class="spacer">
						<td colspan="4"><br/></td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.smallImage" />
						</td>
						<td colspan="3">
							<c:choose>
								<c:when test="${product.id == null or (product.smallImage != null and product.smallImage.id == null)}">
									<input type="file" name="smallImageFile" class="left" size="57"/>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${product.smallImage != null}">
											<div class="disabled-input">${product.smallImage.fileName}</div>
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
						<td class="contenidoTextoInterno">
							<spring:message code="product.image" />
						</td>
						<td colspan="3">
						<c:choose>
							<c:when test="${product.id != null and product.images != null}">
							
								<c:forEach items="${product.images}" var="image" varStatus="count" 
									begin="0" end="0">
									<div class="left">
										<div class="disabled-input">${image.fileName}</div>
										<a href="#" 
											onclick="if (confirm('<spring:message code="are.you.sure.you.want.to.delete.this.picture" />')) sendImageAction('productCreateForm','deleteImage', ${image.id})">
											<spring:message code="delete" />
										</a>
									</div>
								</c:forEach>
							</c:when>
							
							<c:otherwise>
								<div id="newImage_0">
									<input type="file" name="imageFile_0" size="57"/>
									<input type="hidden" name="imageFileOrder_0" value="0"/>
								</div>
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					
					
					<%
						for (int i = 1; i < ConfigConstants.MAX_IMAGE_UPLOAD; i++) {
					%>
					
					<tr style='<%= i > 1 ? "display: none;" : "" %>' id="newImage_<%= i %>">
					
						<td class="contenidoTextoInterno">
						<% if (i == 1) { %>
							<spring:message code="product.gallery.images" />
						<% } else { %>
							<br/>
						<% } %>
						</td>
						
						<td colspan="3">
							<div>
								<input type="file" name="imageFile_<%= i %>" size="45"/>
							<!--  	<input type="text" name="imageFileOrder_<%= i %>" size="1"/> -->
								<% if (i < ConfigConstants.MAX_IMAGE_UPLOAD - 1) { %>
								<a href="#" onclick="show('newImage_<%= i + 1 %>')" class="agregarLink">
									<spring:message code="add" />
								</a>
								<% } %>
							</div>
						</td>
					</tr>
					
					<%
						}
					%>
					

				
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