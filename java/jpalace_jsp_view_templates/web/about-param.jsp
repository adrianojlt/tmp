<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>

<jsp:include page="/WEB-INF/templates/mycom-template-param.jsp">
	<jsp:param name="title" value="About MyCom"/>
	<jsp:param name="body" value="/WEB-INF/about-main.jsp"/>
</jsp:include>

</body>
</html>