<%@page import="java.util.Locale"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
	String pageFrom = request.getParameter("pageFrom");
%>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="menuDerechaSelect"><spring:message code="menu.who.we.are"/></td>
	</tr>
	<tr>
		<td class="navenlace">
			<a href='pudu.html' target="_self">
				<spring:message code="menu.what.is.a.pudu"/>
			</a>
		</td>
	</tr>
	<tr>
		<td class="navenlace">
			<a href="products.html" target="_self"><spring:message code="menu.products"/></a>
		</td>
	</tr>
	<tr>
		<td class="navenlace">
			<a href="contactUs.html" target="_self"><spring:message code="menu.contact.us"/></a>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="menuDerecha">
		<table border="0" cellspacing="0" cellpadding="0">
		
			<tr>
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("sv") %>'>
				
					<c:url value="languageSet.html" var="url">
						<c:param name="lang" value="sv_SE" />
						<c:param name="pageFrom" value="<%= pageFrom %>" />
					</c:url>
					
					<a href='<c:out value="${url}" />' class="banderasLink">
							<img src='<c:url value="/image/idiomaSe.jpg" />'
							name="btnSe" width="20" height="13" border="0" id="btnSe" />
					</a>
				</c:if>
				</td>
				
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("en") %>'>
				
					<c:url value="languageSet.html" var="url">
						<c:param name="lang" value="en_US" />
						<c:param name="pageFrom" value="<%= pageFrom %>" />
					</c:url>
					
					<a href='<c:out value="${url}" />' class="banderasLink">
							<img src='<c:url value="/image/idiomaEn.jpg" />'
							name="btnEn" width="20" height="13" border="0" id="btnEn" />
					</a>
				</c:if>
				</td>
				
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("es") %>'>
				
					<c:url value="languageSet.html" var="url">
						<c:param name="lang" value="es_ES" />
						<c:param name="pageFrom" value="<%= pageFrom %>" />
					</c:url>
					
					<a href='<c:out value="${url}" />' class="banderasLink">
							<img src='<c:url value="/image/idiomaEs.jpg" />'
							name="btnEs" width="20" height="13" border="0" id="btnEs" />
					</a>
				</c:if>
				</td>

			</tr>
		</table>
		</td>
	</tr>
</table>