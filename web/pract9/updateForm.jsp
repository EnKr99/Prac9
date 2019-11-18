<%@page import ="java.sql.*"%>
<%  
    int idTxt = 2;  //init an int variable to contain the product id that is being passed from the previous page (i.e. searchFrom.jsp)
    String brandTxt="";
    String modelTxt="";
    String functionsTxt="";
    String quantityTxt="";
%>
<html>
    <head><title>pract5 part2</title></head>
    <body>
        <h3><%=request.getRequestURI()%></h3>
<%

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
              
              //==> declare and initialise sqlStr SELECT statement here  
              String sqlStr="";
              PreparedStatement pstmt = conn.prepareStatement(sqlStr);
              pstmt.setInt(1, idTxt);
              ResultSet rs = pstmt.executeQuery();
              if(rs.next()){
                  //out.print("id:"+rs.getInt("id"));
                  //out.print("brand:"+rs.getString("brand"));
                  brandTxt=rs.getString("brand");
                  modelTxt=rs.getString("model");
                  functionsTxt=rs.getString("functions");
                  quantityTxt=rs.getString("quantity");
              }else{
                  out.print("nothing retrieved!");
              }
              
              conn.close();
         } catch (Exception e) {
            out.println("<h1>Error :" + e+"<h1>");
            //out.print("<h2>We are sorry that the application is not available at the moment. Pleas call our Helpdesk at 68707070</h2>");
            out.print("<h1>Error code: 1234 in page: "+request.getRequestURI()+"</h1>");
         }              
%>      

    <form name='form2' action="processUpdate.jsp" method="get"> 
        <table border='0' padding="10"> 
   
            <tr bgcolor='#d6d6c2'><td colspan='3' align='center'>Update Record</td></tr>
            <tr><td colspan='3'>&nbsp</td></tr>            
            <tr><td width='20%'>Brand:</td><td colspan='2'><input type='text' name='frmBrand' value='' /></td></tr>
            <tr><td width='20%'>Model:</td><td colspan='2'><input type='text' name='frmModel' value='' /></td></tr>
            <tr><td width='20%'>Functions:</td><td colspan='2'><input type='text' name='frmFunct' value='' size="50"/></td></tr>
            <tr><td width='20%'>Quantity:</td><td colspan='2'><input type='text' name='frmQty' value='' /></td></tr> 
            <tr><td colspan='3'>&nbsp</td></tr>
            <tr><td width='20%'></td><td colspan='2'>
            <input type="hidden" name="frmID" value="" />        
            <input type="submit" name="btnsubmit" value="Update now!" />&nbsp
            <input type="reset" name="btnreset" value="Reset" /></td><tr>     
        </table>
    </form>      


    <body>
</html>
