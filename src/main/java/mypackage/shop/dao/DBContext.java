package mypackage.shop.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    
    private final String SERVER_NAME = "shopdb-mysql12-student-92f8.h.aivencloud.com"; 
   
    private final String PORT_NUMBER = "15276"; 
    
    private final String DB_NAME = "defaultdb"; 
    
    private final String USER_ID = "avnadmin"; 
    
    private final String PASSWORD = "AVNS_ge2IzDma7nZ7gW5YVM-"; 

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        String url = "jdbc:mysql://" + SERVER_NAME + ":" + PORT_NUMBER + "/" + DB_NAME + "?ssl-mode=REQUIRED";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, USER_ID, PASSWORD);
    }

}