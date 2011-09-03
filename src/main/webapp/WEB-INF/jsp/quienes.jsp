<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<jsp:include page="/WEB-INF/includes/header.jsp">
	<jsp:param value="El Pudu" name="title"/>
</jsp:include>



<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="contenido" align="center" valign="middle">&nbsp;</td>
	</tr>
	<tr>
    	<td class="contenido" valign="middle" align="center">
		<table border="0" cellspacing="0" cellpadding="0" align="center" class="tablaContenidoQuienes">
			<tr>
				
				<td class="SeccionesMenu">
					<jsp:include page="/WEB-INF/includes/menu-lateral.jsp">
						<jsp:param value="whoWeAre.html" name="pageFrom"/>
					</jsp:include>
				</td>
				
				
				<td class="SeccionesContenido">
				<table height="24" border="0" cellpadding="0" cellspacing="0" class="contenidoTexto">
					<tr>
						<td class="contenidoTextoTitular">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="tablaTitulo">
							<tr>
								<td class="titular"><spring:message code="who.we.are"/></td>
							</tr>
						</table>
						</td>
						<td class="contenidoTextoInterno">
							<spring:message code="content.who.we.are"/>
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