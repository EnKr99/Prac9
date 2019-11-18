/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pract7_Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author common
 */
@WebServlet(name = "AuthenticateServlet", urlPatterns = {"/AuthenticateServlet"})
public class AuthenticateServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();

    //---------------------------------------        
            String username=request.getParameter("loginid");
            String password=request.getParameter("password");
    /*
            if(username.equals("John") && password.equals("abc123")){
                out.print("WELCOME "+username);
                session.setAttribute("LOGIN-STATUS", "YES"); 
            }else{
             out.print("Sorry.. you have entered the wrong username or password!");
            }
    */
    //---------------------------------------
            boolean userExist_Flag=false;
        //=======================================
        //here is where I will be checking with the db if the record exist.
        try {
          // Step1: Load JDBC Driver
          Class.forName("com.mysql.jdbc.Driver");

          // Step 2: Define Connection URL
          String connURL ="jdbc:mysql://localhost/db1?user=root&password=12345"; 

          // Step 3: Establish connection to URL
          Connection conn = DriverManager.getConnection(connURL); 
          // Step 4: Create Prepared Statement object
          //String sqlStr = "SELECT * FROM member WHERE name='"+userID+"' AND password='"+userPwd+"'";
          String sqlStr = "SELECT * FROM login WHERE userid=? AND password=?";
          PreparedStatement pstmt = conn.prepareStatement(sqlStr);
          // Step 5: Execute SQL Command ***using Prepared Statement***
          pstmt.setString(1, username);
          pstmt.setString(2, password);
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
                out.print("Welcome! "+username);
                session.setAttribute("LOGIN-STATUS", "YES");  //initialise session object - LOGIN-STATUS to 'yes'
                //response.sendRedirect("DisplayTimeTable.jsp");
        } else {
                out.print("Fail");
                //response.sendRedirect("login.html");
                /*
                Below shows the use of queryString [?login=fail] to append more info such as param 'login' with a value of 'fail' to the redirected site
                */    
                response.sendRedirect("Pract/Pract7/login.html"); 
        }
    
    //----------------------------------------

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
