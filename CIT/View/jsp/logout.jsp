<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8" import="java.util.Enumeration,javax.servlet.http.Cookie"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt">
    <head>
        <title>Registo Nacional de Certificados de Incapacidade Temporária</title>
        <jsp:include page="head.jsp"/>
        <c:set var="logoutReason" value="${param.reason}"/>
        <c:choose>
            <c:when test="${logoutReason == 'expired'}">
                <meta HTTP-EQUIV="REFRESH" content="10; url=logout.jsp"> 
            </c:when>
        </c:choose>
    </head>
    <body>
        <div id="preload" class="splashDiv"></div>
        <div id="splash" class="loadDiv">
        <script type="text/javascript">
            var bar1= createBar(150,15,'rgb(247,247,247)',0,'white','blue',50,15,10,"");
        </script>
        <br>
        <span style="font-family:Tahoma, Verdana, Helvetica, sans-serif;text-align: center;vertical-align:top;font-size:9px;color:#779EC7;font-weight:bold;">
            <c:choose>
                <c:when test="${logoutReason == 'expired'}">
                    A sua sessão expirou por inactividade...<br>
                    <a class="errorMessageText" href="logout.jsp">Logout</a>
                </c:when>
                <c:otherwise>
                    <%
                        String contextPath = request.getContextPath().replaceAll("/","");
                        String index = "/" + contextPath + "/";
                        response.setHeader("Osso-Return-Url", index);
                        try{
                        request.getSession(false).invalidate();
                        }catch(Exception e){ }
                        // Send Dynamic Directive for logout
                        response.sendError(470, "Oracle SSO");
                    %>  
                </c:otherwise>
            </c:choose>
        </span>
        </div>  
    </body>
</html>
