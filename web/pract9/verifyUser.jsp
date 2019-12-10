<%@page import ="java.sql.*"%>
<%
    String userID = request.getParameter("loginid");  //*** read in the values from the form object using the request object getParameter() method
    String userPwd = request.getParameter("password"); //***
%>
<html>
<head><title>Pract5 Part2</title></head>
<body>

    <h3><%=request.getRequestURI()%></h3>
    User Name: <%= userID%> <br>
    User Password: <%= userPwd%> <br><br>
    <%
        boolean userExist_Flag=false;
        //=======================================
        //here is where I will be checking with the db if the record exist.
    try {
          // Step1: Load JDBC Driver
          Class.forName("com.mysql.jdbc.Driver");

          // Step 2: Define Connection URL
          String connURL ="jdbc:mysql://localhost/onlineShop?user=root&password=12345"; 

          // Step 3: Establish connection to URL
          Connection conn = DriverManager.getConnection(connURL); 
          // Step 4: Create Prepared Statement object
          
          //"SELECT * FROM member WHERE name='"+userID+"' AND password='"+userPwd+"'";
          String sqlStr = "SELECT * FROM login WHERE userid=? AND password=?";  //*** SELECT prepare statement here
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
    
          // Step 5: Execute SQL Command ***using Prepared Statement***
          /**** Insert pstmt object initialisation here
          *
          */
          pstmt.setString(1,userID);
          pstmt.setString(2,userPwd);

          ResultSet rs = pstmt.executeQuery();  //**notice that the executeQuery() does required the passing in of the SQL query

          // Step 6: Process Result
          if(rs.next()) {
               userExist_Flag=true;
          }else{
          // do nothing since by default userExist_Flag is false
          }
        
          // Step 7: Close connection
          conn.close();
     } catch (Exception e) {
        out.println("<h1>Error :" + e+"<h1>");
        //out.print("<h2>We are sorry that the application is not available at the moment. Pleas call our Helpdesk at 68707070</h2>");
        out.print("<h1>Error code: 1234 in page: "+request.getRequestURI()+"</h1>");
     }
        
        //========================================
        if(userExist_Flag==true){
                out.print("Welcome! "+userID);
                response.sendRedirect("searchForm.jsp");
        } else {
                out.print("Fail");
                //response.sendRedirect("login.html");
                /*
                Below shows the use of queryString [?login=fail] to append more info such as param 'login' with a value of 'fail' to the redirected site
                */    
                response.sendRedirect("login.jsp?status=fail"); 
        }
        %>
        <br><br>

 
</body>
</html> 