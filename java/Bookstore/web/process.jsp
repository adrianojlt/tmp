<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<?xml version = "1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- process.jsp -->

<html xmlns = "http://www.w3.org/1999/xhtml">

<head>
   <title>Thank You!</title>

   <link rel = "stylesheet" href = "styles.css" 
      type = "text/css" />
</head>

<body>
   <p class = "bigFont">Thank You</p>

   <p>Your order has been processed.</p>

   <p>Your credit card has been billed:
      <span class = "bold">
         $<c:out value="${total}"/>
      </span>
   </p>
   <% session.invalidate(); %>
</body>

</html>
