<%@page import="java.util.Locale"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<%
	String pageFrom = request.getParameter("pageFrom");
	String origPageFrom = pageFrom;

	int index = pageFrom.lastIndexOf(".");
	if (index > 0) {
		pageFrom = pageFrom.substring(0, index);
	}
%>

<div class="relative menu-container">
<div class="menu">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class='<%= getRowClass("/admin/productList", pageFrom)%>'>
			<c:if test='<%= !isSelected("/admin/productList", pageFrom) %>'>
				<a href='productList.html' target="_self">
			</c:if>
					<spring:message code="menu.product.list"/>
			<c:if test='<%= !isSelected("/admin/productList", pageFrom) %>'>
				</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td class='<%= getRowClass("/admin/categoryList", pageFrom)%>'>
			<c:if test='<%= !isSelected("/admin/categoryList", pageFrom) %>'>
				<a href='categoryList.html' target="_self">
			</c:if>
					<spring:message code="menu.category.list"/>
			<c:if test='<%= !isSelected("/admin/categoryList", pageFrom) %>'>
				</a>
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="menuDerecha">
		<table border="0" cellspacing="0" cellpadding="0" align="right">
		
			<tr>
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("sv") %>'>
				
					<c:url value="/languageSet.html" var="url">
						<c:param name="lang" value="sv_SE" />
						<c:param name="pageFrom" value="<%= origPageFrom %>" />
					</c:url>
					
					<a href='<c:out value="${url}" />' class="banderasLink">
							<img src='<c:url value="/image/idiomaSe.jpg" />'
							name="btnSe" width="20" height="13" border="0" id="btnSe" />
					</a>
				</c:if>
				</td>
				
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("en") %>'>
				
					<c:url value="/languageSet.html" var="url">
						<c:param name="lang" value="en_US" />
						<c:param name="pageFrom" value="<%= origPageFrom %>" />
					</c:url>
					
					<a href='<c:out value="${url}" />' class="banderasLink">
							<img src='<c:url value="/image/idiomaEn.jpg" />'
							name="btnEn" width="20" height="13" border="0" id="btnEn" />
					</a>
				</c:if>
				</td>
				
				<td>
				<c:if test='<%= !RequestContextUtils.getLocale(request).getLanguage().equals("es") %>'>
				
					<c:url value="/languageSet.html" var="url">
						<c:param name="lang" value="es_ES" />
						<c:param name="pageFrom" value="<%= origPageFrom %>" />
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
</div>
</div>

<%!
private static String getRowClass(String linkName, String pageFrom) {
	if (linkName.equalsIgnoreCase(pageFrom)) {
		return "menuDerechaSelect";
	}
	
	return "navenlace";
}

private static boolean isSelected(String linkName, String pageFrom) {
	return (linkName.equalsIgnoreCase(pageFrom));
}
%>