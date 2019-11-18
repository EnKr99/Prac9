/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pract9_Servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author common
 */
@WebServlet(name = "VerifyUserServlet", urlPatterns = {"/VerifyUserServlet"})
public class VerifyUserServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet VerifyUserServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet VerifyUserServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//-------------------------------------------------------
        String userID = request.getParameter("loginid");
        String userPwd = request.getParameter("password");
        HttpSession session = request.getSession();
        Client client = ClientBuilder.newClient();
        WebTarget target = client
                .target("http://localhost:8080/SEP1718/webresources/pract9WS/VerifyUser")
                //.target("http://localhost:8080/MyWS/webresources/pract9WS_dit03")
                //.path("verifyUser")
                .queryParam("userid", userID)
                .queryParam("password", userPwd);
        
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response cat = invocationBuilder.get();
        System.out.println("status: " + cat.getStatus());
        String s = cat.readEntity(String.class);

        if (cat.getStatus() == Response.Status.OK.getStatusCode() && s.equals("true")) {
            System.out.print("User exists!");
            session.setAttribute("USER", userID);
            response.sendRedirect("pract9/searchForm.jsp");
        } else {
            response.sendRedirect("pract9/login.jsp?status=fail");
        }

//---------------------------------------------------------
        }
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
