<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<div class="header">
	<h2>
		<span style="margin-left: 15px; margin-top: 15px;" class="label">BOOK
			<span style="color: white;">STORE</span>
		</span>
	</h2>
	<span style="color: black; margin-left: 15px;"> <s:if
			test="%{#session.username != null  && !hasActionErrors() }">Welcome <s:property
				value="#session.username" /> | <a
				href='<s:url action="logoutLink"/>'>Log out</a>
		</s:if> <s:else>
			<a href='<s:url action="loginLink"/>'>Login</a>
		</s:else>

	</span>

</div>