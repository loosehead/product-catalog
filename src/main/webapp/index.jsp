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
    <table border="0" cellspacing="0" cellpadding="0" align="center">
      <tr>
        <td><img src="image/home01.jpg" width="225" height="600" /></td>
        <td><img src="image/home02.jpg" width="224" height="600" /></td>
        <td><img src="image/home03.jpg" width="226" height="600" border="0" usemap="#Map" /></td>
        <td><img src="image/home04.jpg" width="225" height="600" /></td>
      </tr>
    </table></td>
  </tr>
</table>

<map name="Map" id="Map">
	<area shape="rect" coords="186,406,209,424" href='<c:url value="whoWeAre.html?lang=sv_SE" />' />
	<area shape="rect" coords="186,434,209,452" href='<c:url value="whoWeAre.html?lang=en_US" />' />
	<area shape="rect" coords="186,460,209,477" href='<c:url value="whoWeAre.html?lang=es_ES" />' />
</map>


<jsp:include page="/WEB-INF/includes/footer.jsp" />
