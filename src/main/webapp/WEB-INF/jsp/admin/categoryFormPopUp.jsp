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
			<input type="text" name="category_name" maxlength="250" id="category_name"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("en") ? "default" : "" %>'
				value='<%= request.getParameter("param_category_name") != null ? request.getParameter("param_category_name") : "" %>' /> 
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="category.name_sv" /></td>
		<td>
			<input type="text" name="category_name_sv" maxlength="250" id="category_name_sv"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("sv") ? "default" : "" %>'
				value='<%= request.getParameter("param_category_name_sv") != null ? request.getParameter("param_category_name_sv") : "" %>' /> 
		</td>
	</tr>
	
	<tr>
		<td><spring:message code="category.name_es" /></td>
		<td>
			<input type="text" name="category_name_es" maxlength="250" id="category_name_es"
				class='<%= RequestContextUtils.getLocale(request).getLanguage().equals("es") ? "default" : "" %>'
				value='<%= request.getParameter("param_category_name_es") != null ? request.getParameter("param_category_name_es") : "" %>' /> 
		</td>
	</tr>
	
	<tr>
		<td colspan="2"><div class="spacer-vert"><br/></div></td>
	</tr>
	

	<tr>
		<td colspan="2">
			<div class="right">
				<div class="left cancel">
					<a href="#" onclick="closeDialog('newCategory')" class="left">
						<spring:message code="cancel" />
					</a>
				</div>
				
				<span class="spacer-horiz left"><br/></span>
				
				<div class="ok left">
					<a href="#" onclick="acceptNewCategory()" >
						<spring:message code="accept" />
					</a>
				</div>
			</div>
		</td>
	</tr>

</table>
