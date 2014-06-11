<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MyCom SiteMap</title>
</head>
<body>

Site map:
<ul>
<li>Dinamic using <code>&lt;jsp:include page="..." /&gt;</code></li>
	<ul>
	<li>Using Request Scope context variables:</li>
		<ul>
		<li><a href="home.jsp">Home</a></li>
		<li><a href="about.jsp">About</a></li>
		</ul>
	<li>Using Request Parameters as context variables:</li>
		<ul>
		<li><a href="home-param.jsp">Home</a></li>
		<li><a href="about-param.jsp">About</a></li>
		</ul>
		
	</ul>
<li>Static using <code>&lt;%@ include file="..." &gt;</code></li>
	<ul>
	<li><a href="home-static.jsp">Home</a></li>
	<li><a href="about-static.jsp">About</a></li>
	</ul>
</ul>
</body>
</html>