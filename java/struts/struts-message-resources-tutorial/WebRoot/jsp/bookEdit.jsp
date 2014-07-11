 
<%@ page language="java"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%> 
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
 
<html> 
	<head>
		<title><bean:message key="title.edit"/></title>
	</head>
	<body>
		<%-- create a html form --%>
		<html:form action="bookEdit">
			<html:messages id="err" message="false"> 
				<font style="font-weight:bold; color=#FF0000"><bean:write name="err" /></font><br>
			</html:messages>
			<%-- print out the form data --%>
			<table border="1">
				<tbody>
				<tr>
					<td><bean:message key="label.author"/>:</td>
					<td><html:text property="author" /></td>
				</tr>
				<tr>
					<td><bean:message key="label.title"/>:</td>
					<td><html:text property="title" /></td>
				</tr>
				<tr>
					<td><bean:message key="label.available"/>:</td>
					<td><html:checkbox property="available" /></td>
				</tr>				
				<tr>
					<td colspan="2">
						<html:submit><bean:message key="label.save"/></html:submit>
					</td>
				</tr>
				</tbody>
			</table>
			<%-- hidden field that contains the id of the book --%>
			<html:hidden property="id" />
			
			<%-- set the parameter for the dispatch action --%>
			<html:hidden property="do" value="saveBook" />	
		</html:form>
	</body>
</html>
