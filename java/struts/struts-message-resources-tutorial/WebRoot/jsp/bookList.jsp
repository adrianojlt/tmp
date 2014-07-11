 
<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title><bean:message key="title.list" /></title>
	</head>
	<body>
	
	<table border="1">
	<tbody>
	<%-- set the header --%>
	<tr>
		<td><bean:message key="label.author" /></td>
		<td><bean:message key="label.title" /></td>
		<td><bean:message key="label.available" /></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%-- start with an iterate over the collection books --%>
	<logic:iterate name="bookListForm" property="books" id="book">
	<tr>
		<%-- print out the book informations --%>
		<td><bean:write name="book" property="author" /></td>
		<td><bean:write name="book" property="title" /></td>
		<td><html:checkbox disabled="true" 
						   name="book" 
						   property="available"/>
		</td>
		
		<%-- print out the edit and delete link for each book --%>
		<td><html:link action="bookEdit.do?do=editBook" 
					   paramName="book" 
					   paramProperty="id" 
					   paramId="id">
					   <bean:message key="label.edit" />
			</html:link>
		</td>
		<td><html:link action="bookEdit.do?do=deleteBook" 
					   paramName="book" 
					   paramProperty="id" 
					   paramId="id">
					   <bean:message key="label.delete" />
			</html:link>
		</td>
	</tr>
	</logic:iterate> 
	<%-- end interate --%>
	
	<%-- print out the add link --%>
	<tr>
		<td colspan="5">
			<html:link action="bookEdit.do?do=addBook" 
					   paramName="book" 
					   paramProperty="id" 
					   paramId="id">
					   <bean:message key="label.new" />
			</html:link>
		</td>
	</tr>
	
	</tbody>
	</table>
	</body>
</html>
