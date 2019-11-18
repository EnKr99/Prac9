/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webservices;

import inventory.Inventory;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Produces;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PUT;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 * REST Web Service
 *
 * @author common
 */
@Path("pract9WS")
public class pract9WS {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of VerifyUser
     */
    public pract9WS() {
    }

    /**
     * Retrieves representation of an instance of webservices.pract9WS
     * @param userid
     * @param password
     * @return an instance of java.lang.String
     */
    @GET
    @Path("VerifyUser")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response VerifyUser(@QueryParam("userid") String userid,  
                                      @QueryParam("password") String password) {
        //TODO return proper representation object
        //throw new UnsupportedOperationException();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            // Step 2: Define Connection URL
            //String connURL = "jdbc:mysql://localhost/onlineshop?user=root&password=root";//DBConn.DBConnectionSettings.connectionURL;
            String connURL = "jdbc:mysql://localhost/db1?user=root&password=12345";
            // Step 3: Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);

            String sqlStr = "select * from login where userid=? and password=?";
            PreparedStatement pstmt = conn.prepareStatement(sqlStr);
            pstmt.setString(1, userid);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();
            boolean result = rs.next();
//        String myResult="";
//        if(result){ //if true
//            myResult="true";
//        }else{
//            myResult="false";
//        }
            conn.close();
            rs.close();            
            return Response
                    .status(200)
                    .entity("" + result)
                    .build();

        } catch (ClassNotFoundException | SQLException e) {
            System.out.print("encountered error.." + e.toString());
            return null;
        } 
    }

/*-------------------------------------    */
   
    @GET
    @Path("SearchInventory")
    //@Produces(MediaType.APPLICATION_JSON)
    //@Consumes(MediaType.APPLICATION_JSON)
    public Response SearchInventory(@QueryParam("searchTxt") String searchTxt) throws ClassNotFoundException, SQLException {
        //TODO return proper representation object
        //throw new UnsupportedOperationException();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            // Step 2: Define Connection URL
            String connURL = "jdbc:mysql://localhost/db1?user=root&password=12345";//DBConn.DBConnectionSettings.connectionURL;
            // Step 3: Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);
            //String sqlStr = "Select * from inventory where functions like '%" + searchString + "%' order by brand, model";
            String sqlStr = "Select * from inventory where functions like ? order by brand, model";

            PreparedStatement pstmt = conn.prepareStatement(sqlStr);

            pstmt.setString(1, "%"+searchTxt+"%");
            ResultSet rs = pstmt.executeQuery();

            System.out.println(sqlStr);

            ArrayList<Inventory> al = new ArrayList<Inventory>();
            while (rs.next()) {
                int id = rs.getInt("id");
                String brand = rs.getString("brand");
                String model = rs.getString("model");
                String functions = rs.getString("functions");
                int quantity = rs.getInt("quantity");
                Inventory inv = new Inventory(id, brand, model, functions, quantity);
                al.add(inv);

            }
            System.out.println(al.size()); //for debugging purpose
            GenericEntity<ArrayList<Inventory>> myEntity = new GenericEntity<ArrayList<Inventory>>(al) {};
            return Response
                    .status(200)
                    .entity(myEntity)
                    .build();
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("error encountered..." + e.toString());
            return null;
        }        
    }
/*--------------------------------------   
* Create a new method here for updating the inventory records the database
* The emethod should take in a prodID and return the Inventory Object containing the 
* specified product ID.
*/    
/*---------------------------------------*/    
    /**
     * PUT method for updating or creating an instance of pract9WS
     * @param content representation for the resource
     */
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    public void putJson(String content) {
    }
}
