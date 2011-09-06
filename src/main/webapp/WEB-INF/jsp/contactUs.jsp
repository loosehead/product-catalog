<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu" name="title"/>
</jsp:include>


<script type="text/javascript">
function send(formId) {
	$('#' + formId).submit();
}
</script>


<%
	String messageKey = (String)request.getAttribute("messageKey");
	String disableForm = request.getAttribute("disableForm") != null ? 
			(String)request.getAttribute("disableForm") : "false";
%>

<c:if test="<%= messageKey != null %>">
<script type="text/javascript">
$(function() {
	$('#success-msg').dialog({ 
		title: '<spring:message code="thank.you" />',
		resizable: false,
		width: 300,
		dialogClass: 'success-msg'
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
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="tablaContenidoPudu">
			<tr>

				<td class="SeccionesMenu">
				<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
					<jsp:param value="contactUs.html" name="pageFrom" />
				</jsp:include></td>


				<td class="SeccionesContenido">
				
				<c:if test="<%= messageKey != null %>">
					<div class="inner-title" id="success-msg" style="display: none;">
						<spring:message code="<%= messageKey %>" />
					</div>
				</c:if>

				<table height="24" border="0" cellpadding="0" cellspacing="0"
					class="contenidoTexto">
					<tr>
						<td class="contenidoTextoTitular">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tablaTitulo">
							<tr>
								<td class="titular"><spring:message code="contact" /></td>
							</tr>
						</table>
						</td>
						<td class="contenidoTextoInterno">
						
						<form:form method="post" action="sendMail.html"
							modelAttribute="contact" id="sendMail_form">
						
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="contenidoTextoInternoContacto">
										<spring:message code="name.and.lastname" />
									</td>
								</tr>
								<tr>
									<td>
										<form:input path="name" cssClass="form" disabled="<%= disableForm %>"/>
										<form:errors path="name" cssClass="errors" element="div" />
									</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto">
										<spring:message code="phone.number" />
									</td>
								</tr>
								<tr>
									<td>
										<form:input path="phoneNumber" cssClass="form" disabled="<%= disableForm %>"/>
										<form:errors path="phoneNumber" cssClass="errors" element="div"/>
									</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto">
										<spring:message code="email" />
									</td>
								</tr>
								<tr>
									<td>
										<form:input path="email" cssClass="form" disabled="<%= disableForm %>"/>
										<form:errors path="email" cssClass="errors" element="div" />
									</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto">
										<spring:message code="address.zip.code.city.country" />
									</td>
								</tr>
								<tr>
									<td>
										<form:input path="address" cssClass="form" disabled="<%= disableForm %>"/>
										<form:errors path="address" cssClass="errors" element="div" />
									</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto">
										<spring:message code="comment" />
									</td>
								</tr>
								<tr>
									<td>
										<form:textarea path="comment" cssClass="textarea" disabled="<%= disableForm %>"/>
										<form:errors path="comment" cssClass="errors" element="div" />
									</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto" align="right">
									<c:if test="<%= !Boolean.parseBoolean(disableForm) %>">
										<div class="right enviarLink-container">
											<a href="#" onclick="send('sendMail_form')" class="enviarLink">
												<spring:message code="send" />
											</a>
											<span class="TextoRersaltado">&gt;</span>
										</div>
									</c:if>
									</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td class="contenidoTextoInternoContacto" id="disclaimer">
									<span class="TextoRersaltado"><spring:message code="address" /></span> 
									Av Cononel Diaz 1953 3<br />
									Capital Federal - Buenos Aires - Argentina<br />
									<span class="TextoRersaltado"><spring:message code="phone.number" /></span> 
										005491140496157
									</td>
								</tr>
							</table>
							
						</form:form>

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
