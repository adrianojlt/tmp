<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<%
request.setAttribute("title", "About MyCom");
request.setAttribute("body", "/WEB-INF/about-main.jsp");
%>

<jsp:include page="/WEB-INF/templates/mycom-template.jsp" />

</body>
</html>