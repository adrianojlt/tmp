<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<%
request.setAttribute("title", "Welcome to MyCom");
request.setAttribute("body", "/WEB-INF/home-main.jsp");
%>

<%@ include file="/WEB-INF/templates/mycom-template-static.jsp" %>

</body>
</html>