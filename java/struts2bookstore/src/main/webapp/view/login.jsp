<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>Bookstore Login</title>
</head>

<body>
	<h3>Login Bookstore</h3>
	<s:form action="executeloginLink" method="post">
		<s:textfield name="username" key="label.username" size="30" />
		<s:password name="password" key="label.password" size="30" />
		<s:submit method="executeLogin" align="center" />
	</s:form>
</body>
</html>