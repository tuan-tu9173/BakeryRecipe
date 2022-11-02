package utils;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author DUNGHUYNH
 */
public class DBUtils {

    private static Connection conn;
    private final static String SERVER_NAME = "localhost";
    private final static String DB_NAME = "BakeryRecipe";
    private final static String PORT = "1433";
    private final static String INSTANCE = "";//LEAVE THIS ONE EMPTY IF YOUR SQL IS A SINGLE INSTANCE
    private final static String USER_ID = "sa";
    private final static String PASSWORD = "12345";

    public static Connection getConnection () {
        try {
            if (conn != null)
                return conn;
            String url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + "\\" + INSTANCE + ";databaseName=" + DB_NAME;
            if (INSTANCE == null || INSTANCE.trim().isEmpty())
                url = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT + ";databaseName=" + DB_NAME;
            url += ";encrypt=true;trustServerCertificate=true;CharacterSet=UTF-8";//important to add UTF-8 format
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("==================================Connected=====================================");
            return (conn = DriverManager.getConnection(url, USER_ID, PASSWORD)) != null ? conn : null;
        } catch (SQLException ex) {
            System.out.println("Connection error! " + ex.getMessage());
            ex.printStackTrace();
        } catch (ClassNotFoundException ex) {
            System.out.println("Connection error! " + ex.getMessage());
            ex.printStackTrace();
        } finally {
        }
        return null;
    }
//    public static Connection getConnection() {
//        Connection con = null;
//        try {
//            //1. load driver
//            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//            //2. make connection string
//            String con_url = "jdbc:sqlserver://167.172.92.134:1433;database=BakeryRecipe;encrypt=true;trustServerCertificate=true;CharacterSet=UTF-8";
//            //3. open connection
//            con = DriverManager.getConnection(con_url, "sa", "Huynhvanphu102Exe");
//        } catch (Exception ex) {
//            ex.printStackTrace();
//        }
//        System.out.println("==============================================Connected==============================================");
//        return con;
//    }

    public static void main (String[] args) {
        System.out.println(DBUtils.getConnection());
    }
}
