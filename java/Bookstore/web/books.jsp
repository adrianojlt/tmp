<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<?xml version = "1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- books.jsp -->

<!-- begin document -->
<html xmlns = "http://www.w3.org/1999/xhtml">

<head>
   <title>Book List</title>

   <link rel = "stylesheet" href = "styles.css" 
      type = "text/css" />
</head>

<body>
   <p class = "bigFont">Available Books</p>

   <p class = "bold">Click a link to view book information</p>
      
   <p></p>
   <table class="center">
     <c:forEach items="${titles}" var="book">
       <tr>
          <td class="left">
             <a href="BookServlet?isbn=${book.ISBN}">
                <c:out value="${book.title}"/>, <c:out value="${book.editionNumber}"/>e
             </a>
          </td>
       </tr>
     </c:forEach>  
   </table>
   
</body> 

</html>