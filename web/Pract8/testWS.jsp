<%-- 
    Document   : testWS
    Created on : 4 Nov, 2017, 10:00:27 AM
    Author     : common
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Web Service</title>
    </head>
    <body>

        <h1>Test Web Service</h1>
        ------------using GET-------------
        <form action="http://localhost:8080/HelloWS/webresources/webservice/getSayHello" method="GET">
            Username: <input type="text" name="username" />
            <input type="submit" name="btnSubmit" />
        </form><br><br>
        ------------using POST--------------------------
        <form action="http://localhost:8080/HelloWS/webresources/webservice/postSayHello" method="POST">
            Username: <input type="text" name="username" />
            <input type="submit" name="btnSubmit" />
        </form>
        <br><br>
        ------------test Calculator Restful WS--------------------------
        <!--form action="http://localhost:8080/HelloWS/webresources/calculateWS-root/calculateWS-sub"-->
        <form action="..\CalculatorServlet" >
            num1: <input type="text" name="num1" /><br>
            num2: <input type="text" name="num2" /><br>
            operator: <!--input type="" name="operator" /-->
            <select name="operator">
                <option value="add">add</option>
                <option value="subtract">subtract</option>
                <option value="multiply">multiply</option>
                <option value="divide">divide</option>
            </select>
            <br>
            <input type="submit" name="btnSubmit" />
        </form>
    </body>
</html>
