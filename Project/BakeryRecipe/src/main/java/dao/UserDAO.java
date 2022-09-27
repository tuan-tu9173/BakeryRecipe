/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import dto.User;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Timestamp;
import utils.DBUtils;
import utils.Tools;

/**
 *
 * @author kichi
 */
public class UserDAO {

    private static Connection conn = DBUtils.getConnection();
    private static final String[] USER_COLUMN_NAME_LIST
            = {"ID", "Role", "Email", "Password", "Avatar", "FirstName",
                "LastName", "Gender", "Phone", "Address", "DateRegister", "IsActive", "StoreID"};
    private static final Class[] USER_COLUMN_NAME_CLASS
            = {Integer.class, String.class, String.class, String.class, String.class, String.class,
                String.class, Boolean.class, String.class, String.class, Timestamp.class, String.class, Integer.class};

    //ay da ko xem database code sai r
    public static boolean checkOldPassword(String ID, String password) {
        String sql = "SELECT ID\n"
                + "FROM [User]\n"
                + "WHERE ID = ? AND Password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ID);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error at checkOldPassword: " + e.toString());
        }
        return false;
    }
    private static final String UPDATE_USER_PASSWORD = " UPDATE [User] SET Password = ? WHERE ID= ?";

    public static boolean changePassword(String ID, String password) {
        String sql = UPDATE_USER_PASSWORD;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setString(1, password);
            ps.setString(2, ID);
            //run ps
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Change Password error:");
            e.printStackTrace();
        }
        return false;
    }

    private static final String SELECT_LOGIN = " SELECT ID from [User]\n"
            + "WHERE Email = ? AND Password = ?";

    public static User login(String email, String password) {
        String sql = SELECT_LOGIN;
        try {
            System.out.println(conn);
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setString(1, email);
            ps.setString(2, password);
            //run ps
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                return getUserByID(id);
            }
            return null;
        } catch (Exception e) {
            System.out.println("Login error:");
            e.printStackTrace();
        }
        return null;
    }

    private static final String SELECT_USER_BY_ID = "SELECT "
            + " [ID],[Role],[Email],[Password],[Avatar]"
            + ",[FirstName],[LastName],[Gender],[Phone]"
            + ",[Address],[DateRegister],[IsActive][StoreID]"
            + " FROM [BakeryRecipe].[dbo].[User]"
            + " WHERE [ID] = ? and IsActive = ?";

    public static User getUserByID(int id) {

        String sql = SELECT_USER_BY_ID;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setInt(1, id);
            ps.setInt(2, 1);
            //run ps
            ResultSet rs = ps.executeQuery();
            String[] l = USER_COLUMN_NAME_LIST;
            User user = null;
            if (rs.next()) {
                user = new User(rs.getInt(l[0]), rs.getString(l[1]), rs.getString(l[2]), rs.getString(l[3]), rs.getString(l[4]), rs.getString(l[5]),
                        rs.getString(l[6]), rs.getString(l[7]), rs.getString(l[8]), rs.getString(l[9]), rs.getDate(l[10]), rs.getInt(l[12]));
            }
            return user;
        } catch (Exception e) {
            System.out.println("Login error:");
            e.printStackTrace();
        }
        return null;
    }

    private static final String CHECK_EMAIL_EXIST = "SELECT ID FROM [User] WHERE Email = ?";

    //ham nay dung de kiem tra email co bi trung ko, ap dung khi tao tk moi
    public static boolean checkDuplicateEmail(String email) {
        String sql = CHECK_EMAIL_EXIST;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception ex) {
            System.out.println("checkDuplicateEmail error!" + ex.getMessage());
        }
        return false;
    }

    private static final String INSERT_NEW_USER = "INSERT INTO [User](Role, Email, Password, FirstName, LastName, DateRegister, IsActive) VALUES \n"
            + "(?, ?, ?, ?, ?, ?, 1);";

    //dang ki mot tk moi
    public static boolean register(String email, String password, String firstname, String lastname) {
        String sql = INSERT_NEW_USER;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "baker");
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, firstname);
            ps.setString(5, lastname);
            ps.setDate(6, new Date(System.currentTimeMillis()));
            if (ps.executeUpdate() == 1) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Register error");
            e.printStackTrace();
        }
        return false;
    }
    private static final String UPDATE_USER_IMAGE = "UPDATE [User] SET [Avatar] = ? WHERE Email= ?";

    /** user register with avatar
     * 
     * @param avatar the avatar of the user
     * @return true if login success
     */
    public static boolean register(String email, String password, String firstname, String lastname, String avatar) {
        String sql = UPDATE_USER_IMAGE;
        try {
            if (register(email, password, firstname, lastname)) {
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, avatar);//set avatar path
                ps.setString(2, email);//where user have this email 
                ps.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            System.out.println("Register error");
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        getUserByID(1);
    }

}
