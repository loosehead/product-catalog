<%@page import="com.elpudu.productos.catalogo.domain.ImageFile"%>
<%@page import="com.elpudu.productos.catalogo.domain.Product"%>
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

	$(function() {
		setCategoryValues();
		$('body').addClass('pudu-products');
	});

	function sendImageAction(formId, action, orderNumber) {
		$('#actionParam').val(action);
		$('#imageOrderNumberParam').val(orderNumber);
		$('#' + formId).submit();
	}

	function show(elemId) {
		$('#' + elemId).show();
	}

	function openNewCategory() {
		$('#newCategory').dialog({ 
			title: '<spring:message code="enter.new.category" />',
			resizable: false,
			width: 320
		 });
	}

	function openSelectCategory() {
		$('#selectCategory').dialog({ 
			title: '<spring:message code="category.selection" />',
			resizable: false,
			width: 320
		 });
	}

	function closeDialog(dialogId) {
		$('#' + dialogId).dialog("close");
	}

	function acceptNewCategory() {

		closeDialog('newCategory');
		setCategoryValues();
	}

	function setCategoryValues() {
		
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

		$('#selectCategory').html('');
	}

	function toggleInput(elemId) {
		$('#' + elemId + '_input').show();
		$('#' + elemId + '_div').hide();
		$('#' + elemId + '_link').hide();
		$('#' + elemId + '_delete_link').hide();
	}

	function closeDialog(dialogName) {
		$('#' + dialogName).dialog('close');
	}
		
</script>


<c:if test="${warning != null}">
	<script type="text/javascript">
	
	$(function() {
		$('#warning').dialog({ 
			title: '<spring:message code="warning" />',
			resizable: false,
			width: 300,
			dialogClass: 'error-msg'
		 });
	});
	</script>	
</c:if>




<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" class="tablaContenidoProductos" align="center" id="productForm-container">
			<tr>
			
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-admin.jsp">
						<jsp:param value="/admin/productList.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				<div class="relative">

				<c:if test="${warning != null}">
					<div class="warning" id="warning" style="display:none;">
						<div class="right link-container">
							<a href="#" class="Sector2Link" onclick="closeDialog('warning')">x</a>
						</div>
						<div class="msg">
							<div class="TextoRersaltado"><spring:message code="warning" /></div>
							<spring:message code="${warning}" />
						</div>
					</div>
				</c:if>

				<form:form method="POST" action="productCreate.html" id="productCreateForm"
					enctype="multipart/form-data" onsubmit="copyParameters()">
					
					<c:if test="${product.id != null}">
						<form:hidden path="id"/>
					</c:if>
				
					<input type="hidden" name="action" value="" id="actionParam" />
					<input type="hidden" name="imageOrderNumberParam" value="" id="imageOrderNumberParam" />
					
					<input type="hidden" name="param_category_name" value="" id="param_category_name" />
					<input type="hidden" name="param_category_name_sv" value="" id="param_category_name_sv" />
					<input type="hidden" name="param_category_name_es" value="" id="param_category_name_es" />
					<input type="hidden" name="param_categories" value="" id="param_categories" />
					
					
					<div id="selectCategory" style="display: none;">
						<div class="right link-container">
							<a href="#" class="Sector2Link" onclick="closeDialog('selectCategory')">x</a>
						</div>
						<div class="msg">
							<div class="inner-title">
								<spring:message code="please.select.the.product.categories" />
							</div>
							<form:checkboxes items="${categories}" path="categories" cssClass="categories"
									delimiter="<br/>"  itemValue="id" itemLabel="currentLocaleName"/>
						</div>
							
					</div>
					
					
					<div id="newCategory" style="display: none;">
						<div class="right link-container">
							<a href="#" class="Sector2Link" onclick="closeDialog('newCategory')">x</a>
						</div>
						<div class="msg">
							<div class="inner-title">
								<spring:message code="please.enter.a.new.category" />
							</div>
							<jsp:include page="/WEB-INF/jsp/admin/categoryFormPopUp.jsp"></jsp:include>
						</div>
					</div>
					
					
					
					<table border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
					
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
							<form:input path="name" maxlength="250" size="22" cssClass="left" /> 
							<div class="required left"><br/></div>
							<form:errors path="name" cssClass="errors left" element="div" />
						</td>
						
						<td class="contenidoTextoInterno">
							<div class="right pad-right">
								<spring:message code="product.code" />
							</div>
						</td>
						<td>
							<form:input path="code" maxlength="20" size="10" cssClass="left" /> 
							<div class="required left"><br/></div>
							<form:errors path="code" cssClass="errors left" element="div"  />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.name_sv" />
						</td>
						<td>
							<form:input path="name_sv" maxlength="250" size="22" cssClass="left" /> 
							<form:errors path="name_sv" cssClass="errors left" element="div" />
							<div class="right" style="width: 20px;"><br/></div>
						</td>
						
						<td class="contenidoTextoInterno">
							<div class="right pad-right">
								<spring:message code="product.name_es" />
							</div>
						</td>
						<td>
							<form:input path="name_es" maxlength="250" size="22" cssClass="left" /> 
							<form:errors path="name_es" cssClass="errors left" element="div"  />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description" />
						</td>
						<td colspan="3">
							<form:textarea path="description" rows="1" cols="60" cssClass="left" /> 
							<div class="required left"><br/></div>
							<form:errors path="description" cssClass="errors left" element="div" />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description_sv" />
						</td>
						<td colspan="3">
							<form:textarea path="description_sv" rows="1" cols="60" cssClass="left"  /> 
							<form:errors path="description_sv" cssClass="errors left" element="div"  />
						</td>
					</tr>
					
					<tr>
						<td class="contenidoTextoInterno">
							<spring:message code="product.description_es" />
						</td>
						<td colspan="3">
							<form:textarea path="description_es" rows="1" cols="60" cssClass="left" /> 
							<form:errors path="description_es" cssClass="errors left" element="div"  />
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
								<c:when test="${product.smallImage == null}">
									<input type="file" name="smallImageFile" class="left" size="40"/>
								</c:when>
								<c:otherwise>
									<input type="file" name="smallImageFile" class="left" size="40" 
										id="smallImageFile_input" style="display: none;" />
										
									<div id="smallImageFile_div" class="disabled-input">
										${product.smallImage.fileName}
									</div>
									
									<a href="#" onclick="toggleInput('smallImageFile')" class="agregarLink edit"
										id="smallImageFile_link" title='<spring:message code="change" />'>
									</a>
									
									<a href='#' onclick="sendImageAction('productCreateForm', 'deleteSmallImage', '')" 
										class="agregarLink delete" id="smallImageFile_delete_link"
										title='<spring:message code="delete" />'>
									</a>
										
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					
					

					<c:forEach begin="0" end="<%= ConfigConstants.MAX_IMAGE_UPLOAD - 1 %>" 
						varStatus="status">
					
						<tr id='newImage_<c:out value="${status.index}" />'>
					
						<td class="contenidoTextoInterno">
						<c:if test="${status.index == 0}">
							<spring:message code="product.image" />
						</c:if>
						<c:if test="${ status.index == 1 }">
							<spring:message code="product.gallery.images" />
						</c:if>
						<c:if test="${ status.index > 1 }">
							<br/>
						</c:if>
						</td>
						
						<td colspan="3">
							<div>
								<c:choose>
									<c:when test="${product.images != null and product.imagesByOrderNumber[status.index] != null}">
									
										<input type="file" name='imageFile_<c:out value="${status.index}" />' size="40" class="left"
											id='imageFile_<c:out value="${status.index}" />_input' style="display: none;"/>
											
										<div id='imageFile_<c:out value="${status.index}" />_div' class="disabled-input">
											${product.imagesByOrderNumber[status.index].fileName}
										</div>
										
										<a href="#" onclick="toggleInput('imageFile_<c:out value="${status.index}" />')" 
											class="agregarLink edit" id="imageFile_<c:out value="${status.index}" />_link"
											title='<spring:message code="change" />'>												
										</a>
										
										<a href='#' onclick="sendImageAction('productCreateForm', 'deleteImage', '${status.index}')" 
											class="agregarLink delete" title='<spring:message code="delete" />'
											id="imageFile_<c:out value="${status.index}" />_delete_link">
										</a>
											
									</c:when>
									
									<c:otherwise>
										<div id='newImage_<c:out value="${status.index}" />'>
											<input type="file" name='imageFile_<c:out value="${status.index}" />' size="40"/>
										</div>
									</c:otherwise>
								</c:choose>
								
							</div>
						</td>
					</tr>
					
					</c:forEach>
					
					<tr>
						<td colspan="4" class="contenidoTextoInterno">
							<div class="required left"><br/></div>
							<spring:message code="required" />
						</td>
					</tr>
				
				</table>
				
						<div class="actions">
							<c:choose>
								<c:when test="${product.id == null}">
									<button type="submit" name="actionBt" value="create" class="create-action">
										<spring:message code="create" />
										<span class="TextoRersaltado">&gt;</span>
									</button>
								</c:when>
								<c:otherwise>
									<button type="submit" name="actionBt" value="delete" class="delete-action"
										onclick="return confirm('<spring:message code="are.you.sure.you.want.to.delete.this.product" />')">
										<spring:message code="delete" />
										<span class="TextoRersaltado">&gt;</span>
									</button>
									<button type="submit" name="actionBt" value="update" class="update-action">
										<spring:message code="update" />
										<span class="TextoRersaltado">&gt;</span>
									</button>
								</c:otherwise>
							</c:choose>
							<button type="submit" name="actionBt" value="back">
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