<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link href="${requestScope.css}" type="text/css" rel="stylesheet" />
  <title> ${requestScope.title} </title>
</head>
<body>
  <jsp:include page="${param.header}" />

  <table><tr>
  <td> <jsp:include page="${param.menu}" /> </td>
  <td>
    <!--page specific content -->
  	<jsp:include page="${param.body}" />  
 </td>
  </table></tr>
  <jsp:include page="${param.footer}" />

</body>
</html>
