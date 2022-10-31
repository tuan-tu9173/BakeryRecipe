package dao;

import java.sql.ResultSet;
import java.sql.PreparedStatement;
import dto.User;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;
import javax.servlet.http.Part;
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
                "LastName", "Gender", "Phone", "Address", "DateRegister", "IsActive", "StoreID", "Birthday"};
    private static final Class[] USER_COLUMN_NAME_CLASS
            = {Integer.class, String.class, String.class, String.class, String.class, String.class,
                String.class, Boolean.class, String.class, String.class, Timestamp.class, String.class, Integer.class};

    //ay da ko xem database code sai r
    public static boolean checkOldPassword (String userID, String password) {
        String sql = "SELECT ID\n"
                + "FROM [User]\n"
                + "WHERE ID = ? AND Password = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            System.out.println(userID + " " + password);
            ps.setString(1, userID);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println(password);
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error at checkOldPassword: " + e.toString());
        }
        return false;
    }

    public static boolean changeStatus (User user) {
        String sql = "UPDATE [User]\n"
                + "SET [IsActive] = ?\n"
                + "WHERE [ID] = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setBoolean(1, user.isIsActive());
            ps.setInt(2, user.getId());
            boolean check = ps.executeUpdate() > 0;
            if (check)
                return true;
        } catch (Exception e) {
            System.out.println("Error at changeStatus: " + e.toString());
        }
        return false;
    }

    public static boolean changeRole (User user) {
        String sql = "UPDATE [User]\n"
                + "SET [Role] = ?\n"
                + "WHERE [ID] = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getRole());
            ps.setInt(2, user.getId());
            boolean check = ps.executeUpdate() > 0;
            if (check)
                return true;
        } catch (Exception e) {
            System.out.println("Error at changeRole: " + e.toString());
        }
        return false;
    }

    private static final String UPDATE_USER_PASSWORD = " UPDATE [User] SET Password = ? WHERE ID= ?";

    public static boolean changePassword (String userID, String password) {
        String sql = UPDATE_USER_PASSWORD;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setString(1, password);
            ps.setString(2, userID);
            //run ps
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Change Password error:");
            e.printStackTrace();
        }
        return false;
    }

    public static User loginWithGoogle (String email) {
        String sql = SELECT_USER_BY_EMAIL;
        try {
            System.out.println(conn);
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setString(1, email);
            //run ps
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                return getUserByID(id);
            }
            return null;
        } catch (Exception e) {
            System.out.println("loginWithGoogle error:");
            e.printStackTrace();
        }
        return null;
    }
    private static final String SELECT_LOGIN = " SELECT ID from [User]"
            + "WHERE Email = ? AND Password = ?";

    //ham nay tim user su dung email va password
    public static User login (String email, String password) {
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

    private static final String SELECT_ALL_USER = "SELECT "
            + " [ID],[Role],[Email],[Password],[Avatar]"
            + ",[FirstName],[LastName],[Gender],[Phone]"
            + ",[Address],[DateRegister],[IsActive][StoreID], [Birthday]"
            + " FROM [BakeryRecipe].[dbo].[User]";

    /**
     * Get All User this <b>method</b> select all the <b>User</b>
     *
     * @param id the <b>id</b> of the <b>User</b>
     *
     * @return the User Object with the same <b>id</b> as the inputted <b>id</b>
     */
    public static List<User> getAllUser () {
        String sql = SELECT_ALL_USER;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            String[] l = USER_COLUMN_NAME_LIST;
            List<User> list = new ArrayList<>();
            User user = null;
            while (rs.next()) {
                user = new User(rs.getInt(l[0]), rs.getString(l[1]), rs.getString(l[2]), rs.getString(l[3]), rs.
                        getString(l[4]), rs.getString(l[5]),
                        rs.getString(l[6]), rs.getString(l[7]), rs.getString(l[8]), rs.getString(l[9]), rs.
                        getDate(l[10]), rs.getInt(l[12]), rs.getDate(l[13]));
                list.add(user);
            }
            return list;
        } catch (Exception e) {
            System.out.println("Login error:");
            e.printStackTrace();
        }
        return null;
    }

    private static final String SELECT_USER_BY_ID = "SELECT [ID],[Role],[Email],[Password],[Avatar],[FirstName],[LastName],[Gender],[Phone]\n"
            + ",[Address], [Following],[Follower],[DateRegister],[IsActive],[StoreID], [Birthday]\n"
            + "FROM [BakeryRecipe].[dbo].[User]\n"
            + "WHERE [ID] = ?";

    /**
     * Get User by ID but this <b>method</b> only select the <b>User</b> that
     * <b>not banned</b>
     *
     * @param id the <b>id</b> of the <b>User</b>
     *
     * @return the User Object with the same <b>id</b> as the inputted <b>id</b>
     */
    public static User getUserByID (int id) {
        String sql = SELECT_USER_BY_ID;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            //Set ps
            ps.setInt(1, id);
            //run ps
            ResultSet rs = ps.executeQuery();
            User user = null;
            if (rs.next())
                user = new User(rs.getInt("ID"),
                        rs.getString("Role"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Avatar"),
                        rs.getString("FirstName"),
                        rs.getString("LastName"),
                        rs.getString("Gender"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getInt("Following"),
                        rs.getInt("Follower"),
                        rs.getDate("DateRegister"),
                        rs.getBoolean("IsActive"),
                        rs.getInt("StoreID"),
                        rs.getDate("Birthday"));
            return user;
        } catch (Exception e) {
            System.out.println("Login error:");
            e.printStackTrace();
        }
        return null;
    }

    private static final String SELECT_USER_BY_EMAIL = "SELECT ID FROM [User] WHERE Email = ?";

    //ham nay dung de kiem tra email co bi trung ko, ap dung khi tao tk moi
    public static boolean checkDuplicateEmail (String email) {
        String sql = SELECT_USER_BY_EMAIL;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception ex) {
            System.out.println("checkDuplicateEmail error!" + ex.getMessage());
        }
        return false;
    }

    private static final String INSERT_NEW_USER = "INSERT INTO [User](Role, Email, Password, FirstName, LastName, DateRegister, IsActive) VALUES \n"
            + "(?, ?, ?, ?, ?, ?, 1);";

    //dang ki mot tk moi
    public static boolean register (String email, String password, String firstname, String lastname) {
        String sql = INSERT_NEW_USER;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "baker");
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, firstname);
            ps.setString(5, lastname);
            ps.setDate(6, new Date(System.currentTimeMillis()));
            if (ps.executeUpdate() == 1)
                return true;
        } catch (Exception e) {
            System.out.println("Register error");
            e.printStackTrace();
        }
        return false;
    }

    /**
     * user register with avatar
     *
     * @param avatar the avatar of the user
     *
     * @return true if login success
     */
    public static boolean register (String email, String password, String firstname, String lastname, String avatar) {
        if (register(email, password, firstname, lastname)) {
            updateAvatar(email, avatar);
            return true;
        }
        return false;
    }
    private static final String UPDATE_USER_IMAGE = "UPDATE [User] SET [Avatar] = ? WHERE Email= ?";

    public static boolean updateAvatar (String email, String avatar) {
        String sql = UPDATE_USER_IMAGE;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, avatar);//set avatar path
            ps.setString(2, email);//where user have this email 
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Update Avatar error");
            e.printStackTrace();
        }
        return false;
    }

    private static final String SEARCH_CHEFNAME = "SELECT [ID],[Role],[Email],[Password],"
            + "[Avatar],[FirstName],[LastName],[Gender],[Phone]"
            + ",[Address],[DateRegister],[IsActive],[StoreID]\n"
            + "FROM [dbo].[User]\n"
            + "WHERE  [LastName] like ? or [FirstName] like ?";

    public List<User> searchName (String search) throws SQLException {
        ArrayList<User> listName = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_CHEFNAME);
                ptm.setString(1, "%" + search + "%");
                ptm.setString(2, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int ID = rs.getInt("ID");
                    String role = rs.getString("Role");
                    String email = rs.getString("Email");
                    String avatar = rs.getString("Avatar");
                    String password = rs.getString("Password");
                    String FirstName = rs.getString("FirstName");
                    String LastName = rs.getString("LastName");
                    String Gender = rs.getString("Gender");
                    String phone = rs.getString("Phone");
                    String address = rs.getString("Address");
                    Date DateRegister = rs.getDate("DateRegister");
                    boolean isActive = rs.getBoolean("IsActive");
                    int StoreId = rs.getInt("StoreID");
                    User user = new User(ID, role, email, password, avatar, FirstName, LastName, Gender, phone, address, DateRegister, isActive, StoreId);
                    listName.add(user);
                }
            }
        } catch (Exception e) {
            System.out.println("System have problem !!!" + e.toString());

        }
        return listName;
    }

    public static boolean EditInfo (User user) {
        String sql = "UPDATE [User]\n"
                + "SET FirstName = ?,\n"
                + "    LastName = ?,\n"
                + "    Phone = ?,\n"
                + "    Birthday = ?,\n"
                + "    Gender = ?,\n"
                + "    [Address] = ?,\n"
                + "	Avatar = ?\n"
                + "WHERE ID = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            System.out.println(user.getAvatar());
            ps.setString(1, user.getFirstName());
            ps.setString(2, user.getLastName());
            ps.setString(3, user.getPhone());
            ps.setDate(4, user.getBirthday());
            ps.setString(5, user.getGender());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getAvatarToDB());
            ps.setInt(8, user.getId());
            boolean check = ps.executeUpdate() > 0;
            if (check)
                return true;
        } catch (Exception e) {
            System.out.println("Error at editInfo: " + e.toString());
        }
        return false;
    }

    //ham nay bi loi, tam thoi comment - PhuHV
    public static String saveAvatar (String filename, Part file, ServletContext sc) {
        try {
            String fileName = file.getSubmittedFileName();
            if (fileName.isEmpty())
                return null;
            // refines the fileName in case it is an absolute path
            fileName = new File(fileName).getName();
            filename += fileName.substring(fileName.indexOf('.'), fileName.length());
            String absoluteFilepath = sc.getRealPath("/" + User.IMG_PATH);
            String webFilepath = absoluteFilepath.
                    replace("\\target\\BakeryRecipe-1.0-SNAPSHOT\\", "\\src\\main\\webapp\\");
            Tools.getFolderUpload(absoluteFilepath);
            Tools.getFolderUpload(webFilepath);
            file.write(absoluteFilepath + filename);
            file.write(webFilepath + filename);
            return filename;
        } catch (IOException ex) {
            System.out.println("Error Cant Save Avatar!" + ex.getMessage());
        }
        return null;
    }

    private static final String LIST_USER
            = " select [Email], [LastName],[FirstName] ,[Avatar] ,userRep.ID  \n" +
" from [dbo].[User] userRep join [dbo].[Recipe] recipe  \n" +
" on userRep.ID=recipe.UserID  \n" +
" where recipe.ID = ?";

    public static User userDetail (int recipeID) {
        User user = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {

            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIST_USER);
                ptm.setInt(1, recipeID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int userID = rs.getInt("ID");
                    String lastName = rs.getString("LastName");
                    String firstName = rs.getString("FirstName");
                    String Avatar = rs.getString("Avatar");
                    String fullName = lastName + " " + firstName;
                    user = new User(userID, Avatar, fullName);

                }
            }
        } catch (Exception e) {
            System.out.println("System have a problem");
            e.printStackTrace();
        }
        return user;
    }

    private static final String FOLLOW = "INSERT INTO [dbo].[Follow]([UserID],[UserID2]) VALUES(?,?)";

    public static boolean followUSer (int IDUser1, int IDUser2) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(FOLLOW);
                ptm.setInt(1, IDUser1);
                ptm.setInt(2, IDUser2);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String UN_FOLLOW = "delete [dbo].[Follow] where UserID =? and UserID2 = ?";

    public boolean UNFollow (int userID1, int userID2) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UN_FOLLOW);
                ptm.setInt(1, userID1);
                ptm.setInt(2, userID2);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String SAVE = "INSERT INTO [Save] (RecipeID, UserID) VALUES (?, ?)";

    public static boolean SaveRecipe (int recipeID, int userID) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SAVE);
                ptm.setInt(1, recipeID);
                ptm.setInt(2, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;

    }

    private static final String UN_SAVED = "DELETE [Save] WHERE [Save].RecipeID = ? AND [Save].UserID = ?";

    public boolean Unsave (int recipeID, int userID) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UN_SAVED);
                ptm.setInt(1, recipeID);
                ptm.setInt(2, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String CHECK_SAVE_RECIPE = "SELECT *\n"
            + "FROM [Save]\n"
            + "WHERE UserID = ? AND RecipeID = ?";

    public static boolean checkSaveRecipe (int userID, int recipeID) {
        boolean check = false;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(CHECK_SAVE_RECIPE);
            ps.setInt(1, userID);
            ps.setInt(2, recipeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String CHECK_FOLLOW_USER = "SELECT *\n"
            + "FROM [Follow]\n"
            + "WHERE UserID = ? AND UserID2 = ?";

    public static boolean checkFollowUser (int userID, int userID2) {
        boolean check = false;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(CHECK_FOLLOW_USER);
            ps.setInt(1, userID);
            ps.setInt(2, userID2);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String LIKE = "INSERT INTO [Like] (RecipeID, UserID) VALUES (?, ?)";

    public boolean LikeRecipe (int recipeID, int userID) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(LIKE);
                ptm.setInt(1, recipeID);
                ptm.setInt(2, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;

    }

    private static final String UN_LIKE = "DELETE [Like] WHERE [Like].RecipeID = ? AND [Like].UserID = ?";

    public boolean Unlike (int recipeID, int userID) {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UN_LIKE);
                ptm.setInt(1, recipeID);
                ptm.setInt(2, userID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String CHECK_LIKE_RECIPE = "SELECT *\n"
            + "FROM [Like]\n"
            + "WHERE UserID = ? AND RecipeID = ?";

    public static boolean checkLikeRecipe (int userID, int recipeID) {
        boolean check = false;
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(CHECK_LIKE_RECIPE);
            ps.setInt(1, userID);
            ps.setInt(2, recipeID);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    private static final String SHOW_USER_LIST = "SELECT \n"
            + "[ID],[Role],[Email],[Password],[Avatar],\n"
            + "[LastName] , [FirstName],[Gender],[Phone],\n"
            + "[Address],[DateRegister],[IsActive],[StoreID], [Birthday]\n"
            + "FROM [BakeryRecipe].[dbo].[User]";

    public static List<User> showUserList () {
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(SHOW_USER_LIST);
            ResultSet rs = ps.executeQuery();
            List<User> list = new ArrayList<>();
            while (rs.next()) {
                String fullName = rs.getString("LastName") + rs.getString("FirstName");
                int ID = rs.getInt("ID");
                String role = rs.getString("Role");
                String email = rs.getString("Email");
                String avatar = rs.getString("Avatar");
                String password = rs.getString("Password");
//                User user = new User(rs.getInt("ID"),
//                        rs.getString("Role"),
//                        rs.getString("Email"),
//                        rs.getString("Password"),
//                        rs.getString("Avatar"),
//                        fullName,
//                        rs.getString("Gender"),
//                        rs.getString("Phone"),
//                        rs.getString("Address"),
//                        rs.getDate("DateRegister"),
//                        rs.getBoolean("IsActive"),
//                        rs.getInt("StoreID"),
//                        rs.getDate("Birthday"));

                int iD = rs.getInt("ID");
                String Role = rs.getString("Role");
                String Email = rs.getString("Email");
                String Avatar = rs.getString("Avatar");
                String Password = rs.getString("Password");
                String FirstName = rs.getString("FirstName");
                String LastName = rs.getString("LastName");
                String Gender = rs.getString("Gender");
                String Phone = rs.getString("Phone");
                String Address = rs.getString("Address");
                Date DateRegister = rs.getDate("DateRegister");
                boolean IsActive = rs.getBoolean("IsActive");
                int StoreId = rs.getInt("StoreID");
                Date Birthday = rs.getDate("Birthday");
                //   User user = new User(iD, role, email, password, avatar, firstName, lastName, gender, phone, address, dateRegister, isActive, storeId);
                User user = new User(iD, Role, Email, Password, Avatar, fullName, FirstName, LastName, Gender, Phone, Address, DateRegister, IsActive, StoreId, Birthday);
                list.add(user);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("UserList Query Error!" + ex.
                    getMessage());
        }
        return null;
    }

    public static List<User> getRecommendUsers (int userID) {
        String sql = "SELECT TOP 5 U.ID, U.Avatar, U.LastName + ' ' + U.FirstName as FullName, U.Follower\n"
                + "FROM [User] U\n"
                + "WHERE U.ID != ? AND U.IsActive = 1\n"
                + "ORDER BY Follower DESC";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            List<User> list = new ArrayList<>();
            User user = null;
            while (rs.next()) {
                user = new User(rs.getInt("ID"), rs.getString("Avatar"), rs.getString("FullName"), rs.getInt("Follower"));
                list.add(user);
            }
            return list;
        } catch (Exception e) {
            System.out.println("getRecommendUsers error:");
            e.printStackTrace();
        }
        return null;
    }
}
