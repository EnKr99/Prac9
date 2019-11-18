<%@page import="java.util.ArrayList"%>
<%@page import="javax.ws.rs.core.GenericType"%>
<%@page import="javax.ws.rs.core.Response"%>
<%@page import="javax.ws.rs.client.Client"%>
<%@page import="javax.ws.rs.core.MediaType"%>
<%@page import="javax.ws.rs.client.Invocation"%>
<%@page import="javax.ws.rs.client.WebTarget"%>
<%@page import="javax.ws.rs.client.ClientBuilder"%>

<%@page import="java.util.ArrayList"%>
<%@page import="inventory.Inventory"%>

<html>
    <head><title>pract9</title></head>
    <body>
<%

    String id = (String)session.getAttribute("USER");
    if(id==null){
        response.sendRedirect("login.jsp?status=fail");
    } 

%>            
        <h3><%=request.getRequestURI()%></h3>
    <form action="../SearchInventoryServlet" name="form1" method="post">
         Search product: <input type="text" name="frmSearch" size="32"><br>
         <input type="submit" name="submit" value="Search">
         <input type="reset" name="submit" value="Reset">
    </form>
    
<%
    int idTxt;
    String brandTxt;
    String modelTxt;
    ArrayList<Inventory> invList = (ArrayList<Inventory>) session.getAttribute("myInvListObj");
    if ((invList != null) && !invList.isEmpty()) {
            out.print("<table border='0' padding='10'><tr bgcolor='#d6d6c2'><td width='20%'>Brand</td><td width='50%'>Model</td><td colspan='2' width='*%'>Actions</td></tr>");
            for (Inventory inv : invList) {    // see Enhanced Loop in Java5 and above in https://www.tutorialspoint.com/java/java_loop_control.htm        
                idTxt = inv.getId();
                brandTxt = inv.getBrand();
                modelTxt = inv.getModel();
                out.print("<tr bgcolor='#f5f5ef'><td>" + brandTxt + "</td><td>" + modelTxt + "</td><td>");
                //out.print("<a href='updateForm.jsp?frmID=" + idTxt + "'><input type='button' value='Update' /></a></td><td>");
                out.print("<a href='../ProcessUpdateServlet?frmID=" + idTxt + "'><input type='button' value='Update' /></a></td><td>");
                out.print("<a href='processDelete.jsp?frmID=" + idTxt + "'><input type='button' value='Delete' /></a>");
                out.print("</td></tr>");
            }
    out.print("</table>");
    }else{
        //out.print("No record found!");
    }
%>    
       
    
    <body>
</html>
