package DAO;

import java.sql.*;

public abstract class DAO {
    private static final String url = "jdbc:mysql://localhost:3306/libman_db";
    private static final String user = "root";
    private static final String password = "123456";

     static {
         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
         } catch (ClassNotFoundException e) {
             throw new RuntimeException(e);
         }
     }

    protected static Connection con() throws ClassNotFoundException, SQLException {
        return DriverManager.getConnection(url, user, password);
    }
}