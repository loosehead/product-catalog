<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page import="com.elpudu.productos.catalogo.domain.Category"%>
<%@page import="java.util.List"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils" %>



					
						
<table>
	<tr>
		<td><spring:message code="category.name" /></td>
		<td>
			<input type="text" name="category_name" maxlength="50" id="category_name"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("en") ? "default" : "" %>' /> 
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="category.name_sv" /></td>
		<td>
			<input type="text" name="category_name_sv" maxlength="50" id="category_name_sv"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("sv") ? "default" : "" %>'/> 
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="category.name_es" /></td>
		<td>
			<input type="text" name="category_name_es" maxlength="50" id="category_name_es"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("es") ? "default" : "" %>'/> 
		</td>
	</tr>
	
	<tr>
		<td colspan="2"><div class="spacer-vert"><br/></div></td>
	</tr>
	

	<tr>
		<td colspan="2">
			<div class="right">
				<a href="#" onclick="closeDialog('newCategory')" class="left">
					<spring:message code="cancel" />
				</a>
				
				<span class="spacer-horiz left"><br/></span>
				
				<a href="#" onclick="acceptNewCategory()" >
					<spring:message code="accept" />
				</a>
			</div>
		</td>
	</tr>

</table>
