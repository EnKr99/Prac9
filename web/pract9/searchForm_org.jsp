<html>
    <head><title>pract5 part2</title></head>
    <body>
        <h3><%=request.getRequestURI()%></h3>
    <form action="" name="form1" method="post">
         Search product: <input type="text" name="frmSearch" size="32"><br>
         <input type="submit" name="submit" value="Search">
         <input type="reset" name="submit" value="Reset">
    </form>
    
<%@page import ="java.sql.*"%>
<%
    String searchTxt=request.getParameter("frmSearch") ; //***read the submitted form textbox object 'frmSearch' value using the request object getParameter() method
    if(searchTxt!=null){
        int idTxt=0;
        String brandTxt="";
        String modelTxt="";
        try {
              // Step1: Load JDBC Driver
              Class.forName("com.mysql.jdbc.Driver");

              // Step 2: Define Connection URL
              String connURL ="jdbc:mysql://localhost/db1?user=root&password=12345"; //***replace schema 'db1' if required

              // Step 3: Establish connection to URL
              Connection conn = DriverManager.getConnection(connURL); 
              // Step 4: Create Statement object
              //Statement stmt = conn.createStatement();
              // Step 5: Execute SQL Command
              
              //==>declare and initialise sqlStr SELECT statement here
              String sqlStr=""; //SELECT * FROM inventory WHERE functions LIKE ?
              PreparedStatement pstmt = conn.prepareStatement(sqlStr);

              /***** Insert pstmt object initialisation here
              *
              */
              
              ResultSet rs = pstmt.executeQuery();

              // Step 6: Process Result
              if(rs.next()){  //check if there is a record beore printing the table below
                rs.previous(); //sets the cursor back to the original position if there is a record. 
                out.print("<table border='0' padding='10'><tr bgcolor='#d6d6c2'><td width='20%'>Brand</td><td width='50%'>Model</td><td colspan='2' width='*%'>Actions</td></tr>");
                while (rs.next()) {
                    idTxt=rs.getInt("id");
                    brandTxt = rs.getString("brand");
                    modelTxt = rs.getString("model");
                    out.println("brand:" + brandTxt + ", model:" + modelTxt +"<br>");
                    /*
                    out.print("<tr bgcolor='#f5f5ef'><td>"+brandTxt+"</td><td>"+modelTxt+"</td><td>");
                    out.print("<form action='updateForm.jsp'>"
                            + "<input type='hidden' name='frmID' value='"+idTxt+"'>"
                            + "<input type='submit' value='Update'/>"
                            + "</form></td><td>");
                    out.print("<form action='processDelete.jsp'>"
                            + "<input type='hidden' name='frmID' value='"+idTxt+"'>"
                            + "<input type='submit' value='Delete'/>"
                            + "</form>");                  
                    //out.print("<a href='updateForm.jsp?frmID="+idTxt+"'><input type='button' value='Update' /></a></td><td>");
                    //out.print("<a href='processDelete.jsp?frmID="+idTxt+"'><input type='button' value='Delete' /></a>");
                    out.print("</td></tr>");
                    */
                }
                out.print("</table>");
              }
              // Step 7: Close connection
              conn.close();
         } catch (Exception e) {
            out.println("<h1>Error :" + e+"<h1>");
            //out.print("<h2>We are sorry that the application is not available at the moment. Pleas call our Helpdesk at 68707070</h2>");
            out.print("<h1>Error code: 1234 in page: "+request.getRequestURI()+"</h1>");
         }
    }
%>        
    
    <body>
</html>
