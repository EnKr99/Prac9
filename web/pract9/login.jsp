<html>
<head>
    <title>SEP Pract5 Part2</title>
</head>
<body>
    <h1>SEP Pract5 Part2</h1>
    <h3><%=request.getRequestURI()%></h3>
<%
    String msg=request.getParameter("status");

    //Method II: check if msg is not null before proceeding to another if condition to evaluate the String comparison.
    if(msg!=null){
        out.print("Sorry Login Fail");
        out.print("===>"+msg);        
    }else{
        //do nothing since msg is null when the page first loaded.
    }

%>
<form action="../VerifyUserServlet" name="form1" method="post">
     User: <input type="text" name="loginid" size="32"><br>
     Password: <input type="text" name="password" size="32"><br>
     <input type="submit" name="submit" value="Login">
     <input type="reset" name="submit" value="Reset">
</form>


</body>
</html>
