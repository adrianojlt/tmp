<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.apress.bookstore.model.Book"%>
<%@page import="com.apress.bookstore.model.Author"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
			String category = request.getParameter("category");
		if(category != null){
		%>
	<div>
		<span class="label" style="margin-left: 15px;"> List of <%= category%>
			Books
		</span>
	</div>

	<%} %>
	<table id="grid">
		<thead>
			<tr>
				<th id="th-title">Book Title</th>
				<th id="th-author">Author</th>
				<th id="th-price">Price</th>
			</tr>
		</thead>


		<tbody>
			<c:forEach items="${allBooks}" var="book">
		
			<tr>
				<th scope="row" id="r100">${book.bookTitle}</th>
				
			
							<c:forEach items="${book.authors}" var="author">
							<c:if test = "${book.id eq author.bookId}">
							<td>${author.firstName}  ${author.lastName}</td>
							</c:if>
							
				  					</c:forEach>
			
				<td>${book.price}</td>

			</tr>

			
  					</c:forEach>
  

		</tbody>

	</table>
</body>
</html>