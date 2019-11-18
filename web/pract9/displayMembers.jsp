<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pract5 part2</title>
    </head>
    <body>
        <h1>Pract5 part2</h1>
<%@page import ="java.sql.*"%>
<%
    String user="";
    String passwd="";
    try {
          // Step1: Load JDBC Driver
          Class.forName("com.mysql.jdbc.Driver");

          // Step 2: Define Connection URL
          String connURL ="jdbc:mysql://localhost/db1?user=root&password=12345"; 

          // Step 3: Establish connection to URL
          Connection conn = DriverManager.getConnection(connURL); 
          // Step 4: Create Statement object
          //Statement stmt = conn.createStatement();
          // Step 5: Execute SQL Command
          String sqlStr = "SELECT * FROM login";         
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
          ResultSet rs = pstmt.executeQuery();

          // Step 6: Process Result
          while (rs.next()) {
              user = rs.getString("userid");
              passwd = rs.getString("password");
	      out.println("userid:" + user + ", password:" + passwd +"<br>");
          }
        
          // Step 7: Close connection
          conn.close();
     } catch (Exception e) {
        out.println("<h1>Error :" + e+"<h1>");
        //out.print("<h2>We are sorry that the application is not available at the moment. Pleas call our Helpdesk at 68707070</h2>");
        out.print("<h1>Error code: 1234 in page: "+request.getRequestURI()+"</h1>");
     }
%>        
        
    </body>
</html>
