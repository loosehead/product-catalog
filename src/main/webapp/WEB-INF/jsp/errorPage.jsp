<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu" name="title"/>
</jsp:include>

<%
	String errorMsgCode = request.getAttribute("error-msg-code") != null ? (String)request.getAttribute("error-msg-code") : null;
%>


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
						<jsp:param value="whoWeAre.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				<table height="24" border="0" cellpadding="0" cellspacing="0" class="contenidoTexto error-page">
					<tr>
						<td class="contenidoTextoInterno">
							<c:choose>
								<c:when test="<%= errorMsgCode != null %>">
									<spring:message code="<%= errorMsgCode %>" />
								</c:when>
								<c:otherwise>
									<spring:message code="this.site.is.temporarily.unavailable"/>
								</c:otherwise>
							</c:choose>
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
