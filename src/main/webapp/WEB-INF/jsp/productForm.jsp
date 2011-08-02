<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1><spring:message code="create.product.title"></spring:message></h1>
	
	<form:form method="POST" action="productCreate.html" enctype="multipart/form-data"
		modelAttribute="product" commandName="product">
		
		<c:if test="${product.id != null}">
			<form:hidden path="id"/>
		</c:if>
	
		
		<table>
		<tr>
			<td><spring:message code="product.name" /></td>
			<td>
				<form:input path="name" maxlength="50" /> 
				<form:errors path="name" cssClass="errors" />
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
				<form:input path="description" maxlength="200" /> 
				<form:errors path="description" cssClass="errors" />
			</td>
		</tr>
		
		<tr>
			<td><spring:message code="product.image" /></td>
			<td>
				<c:choose>
					<c:when test="${product.id == null or (product.image != null and product.image.id == null)}">
						<input type="file" name="imageFile"/>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${product.image != null}">
								<img src="imageView.html?id=${product.image.id}" width="115" border="0" />
								<div>
									<button type="submit" name="action" value="changeImage">Change</button>
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<button type="submit" name="action" value="changeImage">Add</button>
								</div>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	
		<tr>
			<td>
				<c:choose>
					<c:when test="${product.id == null}">
						<button type="submit" name="action" value="create"><spring:message code="create" /></button>
					</c:when>
					<c:otherwise>
						<button type="submit" name="action" value="delete"
							onclick="return confirm('Are you sure you want to delete ${product.name}?')">
							Delete
						</button>
						<button type="submit" name="action" value="update">Update</button>
					</c:otherwise>
				</c:choose>

			</td>
			<td></td>
		</tr>
	
	</table>
	</form:form>

</body>
</html>