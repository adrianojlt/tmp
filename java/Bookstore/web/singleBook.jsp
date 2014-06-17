<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><c:out value="${bookToAdd.title}"/></title>
        
        <link rel = "stylesheet" href = "styles.css" 
        type = "text/css" />
    </head>
    <body>

        <h1><c:out value="${bookToAdd.title}"/></h1>
    
        <table>
            <tr>
                <!-- create table cell for product image -->
                <td rowspan = "5">  <!-- cell spans 5 rows -->
                    <img style = "border: thin solid black" src =  
                    "images/${bookToAdd.imageFile}" 
                    alt = "${bookToAdd.title}"  />
                </td>
 
                <!-- create table cells for price in row 1 -->
                <td class = "bold">Price:</td>

                <td><c:out value="${bookToAdd.fmprice}"/></td>
            </tr>
            
            <tr>

                <!-- create table cells for ISBN in row 2 -->
                <td class = "bold">ISBN #:</td>

                <td><c:out value="${bookToAdd.ISBN}"/></td>
            </tr>
         
            <tr>

                <!-- create table cells for edition in row 3 -->
                <td class = "bold">Edition:</td>

                <td><c:out value="${bookToAdd.editionNumber}"/></td>
            </tr>
         
            <tr>

                <!-- create table cells for copyright in row 4 -->
                <td class = "bold">Copyright:</td>

                <td><c:out value="${bookToAdd.copyright}"/></td>
            </tr>
         
            <tr>

                <!-- create Add to Cart button in row 5 -->
                <td>
                    <form method = "post" action="AddToCartServlet">
                        <p><input type = "submit" value = "Add to Cart" /></p>
                    </form>
                </td>

                <!-- create View Cart button in row 5 -->
                <td>
                    <form method = "get" action="viewCart.jsp">
                        <p><input type = "submit" value = "View Cart" /></p>
                    </form>
                </td>
            </tr>
        
        </table>
    
    </body>
</html>