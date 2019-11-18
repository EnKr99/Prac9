<%-- 
    Document   : resultPage
    Created on : 11 Nov, 2017, 12:34:16 AM
    Author     : common
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Result Page</h1> 
<%
       String msg = request.getParameter("result"); 
       out.print("The result of the calculation is: "+msg); 
%>
    </body>
</html>
