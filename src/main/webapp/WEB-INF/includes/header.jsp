<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String title = request.getParameter("title") != null ? request.getParameter("title") : "El Pudu";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
	<link rel="stylesheet" type="text/css" media="all" href='<c:url value="/style/master.css"/>' /> 
	<link rel="stylesheet" type="text/css" media="all" href='<c:url value="/style/eggplant/jquery-ui-1.8.16.custom.css"/>' /> 
	<script type="text/javascript" src='<c:url value="/js/master.js"/>'></script>
	<script type="text/javascript" src='<c:url value="/js/jquery-1.6.2.min.js"/>'></script>
	<script type="text/javascript" src='<c:url value="/js/jquery-ui-1.8.16.custom.min.js"/>'></script>
	<title><%= title %></title>
</head>
<body id="pudu"
	onload="MM_preloadImages('../image/idiomaSe.jpg','../image/idiomaEn.jpg')">
