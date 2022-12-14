/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Comment;
import dto.Ingredient;
import dto.Instruction;
import dto.Recipe;
import dto.RecipeSearch;
import dto.User;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.http.Part;
import org.checkerframework.common.returnsreceiver.qual.This;
import utils.Tools;

/**
 *
 * @author kichi
 */
public class RecipeDAO {

    private static final String SELECT_MOST_RATED_SQL = "SELECT Recipe.ID, Name, Description, [Like], [Save], Comment, DatePost, LastDateEdit, Img, UserID, LastName + ' ' + FirstName AS Username\n"
            + "                                                        FROM Recipe\n"
            + "                                                        JOIN [User] ON Recipe.UserID = [User].ID\n"
            + "                                                        JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
            + "                                                        WHERE IsDeleted = 0 AND IsCover = 1\n"
            + "                                                        ORDER BY [Like] DESC\n"
            + "			                                 OFFSET ? ROWS FETCH NEXT 8 ROWS ONLY";
    private static final String SELECT_PICTURE_SQL = "SELECT img FROM Picture";

    public static List<Recipe> getMostRatedRecipe(int index) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(SELECT_MOST_RATED_SQL);
            ps.setInt(1, (index - 1) * 8);
            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getMostRatedRecipe Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String SELECT_MOST_RECENT_SQL = "SELECT Recipe.ID, Name, Description, [Like], [Save], Comment, DatePost, LastDateEdit, Img, UserID, LastName + ' ' + FirstName AS Username\n"
            + "                                                        FROM Recipe\n"
            + "                                                        JOIN [User] ON Recipe.UserID = [User].ID\n"
            + "                                                        JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
            + "                                                        WHERE IsDeleted = 0 AND IsCover = 1\n"
            + "                                                        ORDER BY DatePost DESC\n"
            + "			                                 OFFSET ? ROWS FETCH NEXT 8 ROWS ONLY";

    public static List<Recipe> getMostRecentRecipe(int index) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(SELECT_MOST_RECENT_SQL);
            ps.setInt(1, (index - 1) * 8);
            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getMostRecentRecipe Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String SEARCH_RECIPE = "SELECT R.ID,R.[Name],[DatePost],[Like],Comment,[Img],[UserID],U.LastName +' '+U.FirstName as fullName\n"
            + "FROM [dbo].[Recipe] R \n"
            + "JOIN [dbo].[Picture] P on R.ID =P.RecipeID\n"
            + "JOIN [dbo].[User] U\n"
            + "on  U.ID =R.UserID\n"
            + "WHERE FREETEXT (R.Name , ?) and P.IsCover=1 and IsDeleted = 0";

    public static List<Recipe> searchRecipe(String search) throws SQLException {
        ArrayList<Recipe> listRecipe = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(SEARCH_RECIPE);
            ptm.setString(1, search);
            rs = ptm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ID");
                String cakeName = rs.getString("Name");
                int like = rs.getInt("Like");
                int comment = rs.getInt("Comment");
                Timestamp datePost = rs.getTimestamp("DatePost");
                String cover = rs.getString("Img");
                int userId = rs.getInt("UserID");
                String fullName = rs.getString("fullName");
                Recipe recipe;
                recipe = new Recipe(id, cakeName, like, comment, datePost, cover, userId, fullName);
                listRecipe.add(recipe);
            }

        } catch (Exception e) {
            System.out.println("System had a problem ???");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listRecipe;
    }

    public static int getAllRecipe() throws SQLException {
        String sql = "SELECT count(Recipe.ID)\n"
                + "                     FROM Recipe\n"
                + "		      JOIN [User] ON Recipe.UserID = [User].ID\n"
                + "		      JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
                + "                     WHERE IsDeleted = 0 AND IsCover = 1";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }
    private static final String INSERT_RECIPE
            = "INSERT INTO [Recipe]\n"
            + "           ([Name],[Description],[Like],[Save],[Comment]\n"
            + "           ,[Video],[DatePost],[LastDateEdit],[PrepTime],[CookTime]\n"
            + "           ,[IsDeleted],[UserID])\n"
            + "           OUTPUT INSERTED.ID"
            + "    VALUES (?           ,?           ,?           ,?           ,?\n"
            + "           ,?           ,?           ,?           ,?           ,?\n"
            + "           ,?           ,?)";

    public static boolean addRecipe(String recipeName, String recipeDescription,
            String videoUrl, List<Part> pictureList, String[] ingreName,
            String[] ingreAmount, List<Part> instImgList,
            String[] instDescription, int prepareTime, int cookTime, int userId, int cover, ServletContext sc) throws SQLException {
        Connection conn = DBUtils.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = INSERT_RECIPE;
        System.out.println("addrecipe = ");
        String[] returnId = {"ID"};

        try {
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql, returnId);
            //set value
            ps.setString(1, recipeName);
            ps.setString(2, recipeDescription);
            ps.setInt(3, 0);
            ps.setInt(4, 0);
            ps.setInt(5, 0);
            ps.setString(6, videoUrl);
            ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            ps.setTimestamp(8, null);
            ps.setInt(9, prepareTime);
            ps.setInt(10, cookTime);
            ps.setBoolean(11, false);
            ps.setInt(12, userId);
            rs = ps.executeQuery();
            int recipeId = -1;
            if (rs.next()) {
                recipeId = rs.getInt("ID");
                PictureDAO.addPicturesRecipe(pictureList, cover, recipeId, conn, sc);
                IngredientDAO.addIngredientsRecipe(ingreName, ingreAmount, recipeId, conn, sc);
                IntructionDAO.addInstructionsRecipe(instImgList, instDescription, recipeId, conn, sc);
            }
            conn.commit();
            conn.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            System.out.println("Add Recipe ERROR:" + e.getMessage());
            e.printStackTrace();
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
            }
            if (ps != null) {
                ps.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return false;
    }
    private static final String UPDATE_RECIPE = "UPDATE [dbo].[Recipe]\n"
            + "   SET [Name] = ?\n"
            + "      ,[Description] = ?\n"
            + "      ,[Video] = ?\n"
            + "      ,[LastDateEdit] = ?\n"
            + "      ,[PrepTime] = ?\n"
            + "      ,[CookTime] = ?\n"
            + " WHERE Recipe.ID = ?";

    public static boolean updateRecipe(String recipeName, String recipeDescription, String videoUrl,
            List<Part> pictureList, String[] pictureListPath, String[] ingreName, String[] ingreAmount, List<Part> instImgList,
            String[] instDescription, int prepareTime, int cookTime, int userId, int recipeId, int cover,
            ServletContext sc) throws SQLException {
        String sql = UPDATE_RECIPE;
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            conn.setAutoCommit(false);
            ps.setString(1, recipeName);
            ps.setString(2, recipeDescription);
            ps.setString(3, videoUrl);
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.setInt(5, prepareTime);
            ps.setInt(6, cookTime);
            ps.setInt(7, recipeId);
            boolean check = ps.executeUpdate() > 0;
            if (check) {
                check = PictureDAO.updatePicturesRecipe(pictureList, pictureListPath, cover, recipeId, conn, sc);
                if (check) {
                    check = IngredientDAO.updateIngredientsRecipe(ingreName, ingreAmount, recipeId, conn, sc);
                    if (check) {
                        check = IntructionDAO.updateInstructionsRecipe(instImgList, instDescription, recipeId, conn, sc);
                        if (check) {
                            conn.commit();
                            return true;
                        }
                    }
                }
            }
        } catch (IOException ex) {
            Logger.getLogger(RecipeDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (ps != null) {
                ps.close();
            }
        }
        return false;
    }

    private static final String TOP8_MOST_RATED_SQL = "SELECT TOP 8 Recipe.ID, Name, Description, [Like], [Save], Comment, DatePost, LastDateEdit, Img, UserID, LastName + ' ' + FirstName AS Username\n"
            + "FROM Recipe\n"
            + "JOIN [User] ON Recipe.UserID = [User].ID\n"
            + "JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
            + "WHERE IsDeleted = 0 AND IsCover = 1\n"
            + "ORDER BY [Like] DESC";

    public static List<Recipe> getTop8MostRatedRecipe() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(TOP8_MOST_RATED_SQL);

            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getMostRatedRecipe Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String TOP8_MOST_RECENT_SQL = "SELECT TOP 8 Recipe.ID, Name, Description, [Like], [Save], Comment, DatePost, LastDateEdit, Img, UserID, LastName + ' ' + FirstName AS Username\n"
            + "FROM Recipe\n"
            + "JOIN [User] ON Recipe.UserID = [User].ID\n"
            + "JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
            + "WHERE IsDeleted = 0 AND IsCover = 1\n"
            + "ORDER BY [DatePost] DESC";

    public static List<Recipe> getTop8MostRecentRecipe() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(TOP8_MOST_RECENT_SQL);

            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getTop8MostRecentRecipe Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public static List<Recipe> getTop8RandomRecipes() throws SQLException {
        String sql = "SELECT TOP 8 Recipe.ID, Name, Description, [Like], [Save], Comment, DatePost, LastDateEdit, Img, UserID, LastName + ' ' + FirstName AS Username\n"
                + "FROM Recipe\n"
                + "JOIN [User] ON Recipe.UserID = [User].ID\n"
                + "JOIN Picture ON Picture.RecipeID = Recipe.ID\n"
                + "WHERE IsDeleted = 0 AND IsCover = 1\n"
                + "ORDER BY NEWID()";
        ArrayList<Recipe> list = new ArrayList<Recipe>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String SAVED_RECIPES_LIST_SQL = "SELECT Recipe.ID, Recipe.[Name], Recipe.[Description], Recipe.[Like], Recipe.[Save], Recipe.Comment, Recipe.DatePost, Recipe.LastDateEdit, Picture.Img, Recipe.UserID, LastName + ' ' + FirstName AS Username\n"
            + "            FROM [Save]\n"
            + "            JOIN [Recipe] ON [Save].RecipeID = [Recipe].ID\n"
            + "		   JOIN [User] ON [User].ID = [Recipe].UserID\n"
            + "            JOIN [Picture] ON [Recipe].ID = [Picture].RecipeID\n"
            + "            WHERE IsDeleted = 0 AND IsCover = 1 AND [Save].UserID = ?\n"
            + "            ORDER BY Recipe.[Like] DESC\n"
            + "		   OFFSET ? ROWS FETCH NEXT 8 ROWS ONLY";

    public static List<Recipe> showSavedRecipe(int userID, int index) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(SAVED_RECIPES_LIST_SQL);
            ps.setInt(1, userID);
            ps.setInt(2, (index - 1) * 8);
            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getMostRatedRecipe Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    public static int getAllSavedRecipe(int id) throws SQLException {
        String sql = "SELECT count(Recipe.ID)\n"
                + "                     FROM [User]\n"
                + "		      JOIN [Save] ON [Save].UserID = [User].ID\n"
                + "		      JOIN [Recipe] ON [Save].RecipeID = [Recipe].ID\n"
                + "		      JOIN [Picture] ON [Recipe].ID = [Picture].RecipeID\n"
                + "                     WHERE IsDeleted = 0 AND IsCover = 1 AND [User].ID = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return 0;
    }

    private static final String LIST_PICTURE = "  SELECT pic.img,recipe.Video\n"
            + " FROM  [dbo].[Recipe] recipe\n"
            + "join [dbo].[Picture] pic\n"
            + "on pic.RecipeID=recipe.ID\n"
            + "   where recipe.ID = ?";

    public static ArrayList<String> listPicture(int recipeID) throws SQLException {
        ArrayList<String> listPicture = new ArrayList<>();
        Recipe recipe = new Recipe();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LIST_PICTURE);
            ptm.setInt(1, recipeID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String picture = rs.getString("img");
                listPicture.add(picture);
            }
        } catch (Exception e) {
            System.out.println("System have error !!!");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listPicture;

    }

    private static final String LIST_INGREDIENT = "select ingre.[Name],ingre.[Img]\n"
            + " from [dbo].[Ingredient] ingre join [dbo].[IngredientRecipe] ingreRe\n"
            + " on ingre.ID =ingreRe.IngredientID\n"
            + " join [dbo].[Recipe] re on ingreRe.RecipeID =re.ID\n"
            + " where re.ID = ?";

    public List<Ingredient> listIngredient(int recipeID) throws SQLException {
        List<Ingredient> listIgre = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LIST_INGREDIENT);
            ptm.setInt(1, recipeID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String name = rs.getString("Name");
                String img = rs.getString("Img");
                Ingredient sc;
                sc = new Ingredient(name, img);
                listIgre.add(sc);
            }
        } catch (Exception e) {
            System.out.println("System have error !!!");
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listIgre;

    }

    private static final String LIST_STEP = "SELECT [InsStep],[Detail],[Img]\n"
            + " FROM [dbo].[Instruction] instruc join [dbo].[Recipe] recipe \n"
            + " ON instruc.RecipeID = recipe.ID\n"
            + " WHERE recipe.ID = ?"
            + " ORDER BY recipe.ID,InsStep";

    public static List<Instruction> listStep(int recipeID) throws SQLException {
        List<Instruction> liststep = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(LIST_STEP);
            ptm.setInt(1, recipeID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                int step = rs.getInt("InsStep");
                String detailStep = rs.getString("Detail");
                String imgStep = rs.getString("Img");
                Instruction intruc;
                intruc = new Instruction(step, detailStep, imgStep);
                liststep.add(intruc);
            }

        } catch (Exception e) {
            System.out.println("System have error !!!" + e);

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return liststep;
    }

    private static final String POST_HOME_RECIPE_SQL = "(SELECT U2.ID as UserID, U2.LastName + ' ' + U2.FirstName AS Username, U2.Avatar, R.ID, R.Name, R.Description, R.[Like], R.[Save], R.Comment, R.DatePost, P.Img AS Cover\n"
            + "FROM [User] U\n"
            + "JOIN Follow ON U.ID = Follow.UserID\n"
            + "JOIN [User] U2 ON U2.ID = Follow.UserID2\n"
            + "JOIN Recipe R ON R.UserID = Follow.UserID2\n"
            + "JOIN Picture P ON P.RecipeID = R.ID\n"
            + "WHERE U.ID = ? AND R.IsDeleted = 0 AND P.IsCover = 1)\n"
            + "UNION\n"
            + "(SELECT U.ID AS UserID, U.LastName + ' ' + U.FirstName AS Username, U.Avatar, R.ID, R.Name, R.Description, R.[Like], R.[Save], R.Comment, R.DatePost, P.Img AS Cover\n"
            + "FROM Recipe R\n"
            + "JOIN [User] U ON R.UserID = U.ID\n"
            + "JOIN Picture P ON P.RecipeID = R.ID\n"
            + "WHERE R.UserID = ? AND R.IsDeleted = 0 AND P.IsCover = 1)\n"
            + "ORDER BY DatePost DESC";

    public static ArrayList<Recipe> getPostHomeRecipes(int userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(POST_HOME_RECIPE_SQL);
            ps.setInt(1, userID);
            ps.setInt(2, userID);
            rs = ps.executeQuery();
            ArrayList<Recipe> list = new ArrayList<Recipe>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"), rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getString("Cover"),
                        rs.getInt("UserID"),
                        rs.getString("Avatar"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getPostHomeRecipes Query Error!" + ex.
                    getMessage());
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String POST_PROFILE_RECIPE_SQL
            = "SELECT U.ID AS UserID, U.LastName + ' ' + U.FirstName AS Username, U.Avatar, R.ID, R.Name, R.Description, R.[Like], R.[Save], R.Comment, R.DatePost, P.Img AS Cover\n"
            + "FROM Recipe R\n"
            + "JOIN [User] U ON R.UserID = U.ID\n"
            + "JOIN Picture P ON P.RecipeID = R.ID\n"
            + "WHERE R.UserID = ? AND R.IsDeleted = 0 AND P.IsCover = 1\n"
            + "ORDER BY DatePost DESC";

    public static ArrayList<Recipe> getPostProfileRecipes(int userID) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(POST_PROFILE_RECIPE_SQL);
            ps.setInt(1, userID);
            rs = ps.executeQuery();
            ArrayList<Recipe> list = new ArrayList<Recipe>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"), rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getString("Cover"),
                        rs.getInt("UserID"),
                        rs.getString("Avatar"),
                        rs.getString("Username"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("getPostProfileRecipes Query Error!" + ex.
                    getMessage());
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }
    private static final String SELECT_RECIPE_BY_ID
            = "SELECT r.[ID]\n"
            + "      ,[Name]\n"
            + "      ,[Description]\n"
            + "      ,[Like]\n"
            + "      ,[Save]\n"
            + "      ,[Comment]\n"
            + "      ,[Video]\n"
            + "      ,[DatePost]\n"
            + "      ,[LastDateEdit]\n"
            + "      ,[PrepTime]\n"
            + "      ,[CookTime]\n"
            + "      ,[IsDeleted]\n"
            + "      ,[UserID]\n"
            + "	  ,p.Img as Cover"
            + "  FROM [Recipe] r \n"
            + "  LEFT JOIN Picture p on p.IsCover = 1 and r.ID = p.RecipeID "
            + "  WHERE r.ID = ?";

    public static Recipe getRecipeByID(int id) throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.
                    prepareStatement(SELECT_RECIPE_BY_ID);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            Recipe recipe = null;
            if (rs.next()) {
                recipe = new Recipe(id,
                        rs.getString("Name"),
                        rs.getString("Description"),
                        rs.getInt("Like"),
                        rs.getInt("Save"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getInt("PrepTime"), rs.getInt("CookTime"));
                recipe.setCover(rs.getString("Cover"));
                recipe.setUserID(rs.getInt("UserID"));
                return recipe;
            }
        } catch (SQLException ex) {
            System.out.println("Get Recipe By ID Query Error!" + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
            System.out.println("Error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }
    private static final String COOK_DETAIL = "SELECT [Name],[Like],[Save],[Comment],[PrepTime],[CookTime],[Description],[DatePost],DatePost, LastDateEdit \n"
            + "FROM [dbo].[Recipe]recipe join [dbo].[User] baker\n"
            + "on recipe.UserID =baker.ID\n"
            + "WHERE  recipe.ID =?";

    public Recipe recipeDetail(int recipeID) throws SQLException {
        Recipe recipe = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(COOK_DETAIL);
            ptm.setInt(1, recipeID);
//            ptm.setInt(2, recipeID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String name = rs.getString("Name");
                String description = rs.getString("Description");
                int like = rs.getInt("Like");
                int save = rs.getInt("Save");
                int prepTime = rs.getInt("PrepTime");
                int cookTime = rs.getInt("CookTime");
                int comment = rs.getInt("Comment");
//                int bakerID= rs.getInt()

                recipe = new Recipe(recipeID, name, description, like, save, comment, rs.
                        getTimestamp("DatePost"), rs.
                        getTimestamp("LastDateEdit"), prepTime, cookTime);
            }
        } catch (Exception e) {
            System.out.println("System have error !!!" + e);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return recipe;
    }

    private static final String VIDEO_DETAIL = "SELECT [Video]\n"
            + "FROM [dbo].[Recipe] recipe join [dbo].[User] baker\n"
            + "ON recipe.[UserID]= baker.[ID]\n"
            + "WHERE recipe.[ID] = ?";

    public static String recipeVideo(int recipeid) throws SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String theVideo = null;
        try {
            conn = DBUtils.getConnection();
            ptm = conn.prepareStatement(VIDEO_DETAIL);
            ptm.setInt(1, recipeid);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String video = rs.getString("Video");
                theVideo = video;
            }
        } catch (Exception e) {
            System.out.println("recipe Video exception:" + e.getMessage());
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return theVideo;
    }

    private static final String RLATED_BAKER = "SELECT   recipe.Name\n" +
"            FROM [dbo].[Recipe]recipe \n" +
"            WHERE  recipe.IsDeleted ='false' and recipe.UserID = ?";

    public static List<Recipe> RelatewithBaker(int recipeID) throws SQLException {
        Connection cnn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Recipe> listR = new ArrayList<>();
        try {
            cnn = DBUtils.getConnection();
            ptm = cnn.prepareStatement(RLATED_BAKER);
            ptm.setInt(1, recipeID);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String name = rs.getString("Name");
                Recipe recipeD = RecipeDAO.searchRecipebyName(name);
                listR.add(recipeD);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return listR;
    }

    private static final String ALL_NAME = "SELECT   recipe.Name \n"
            + "            FROM [dbo].[Recipe]recipe \n"
            + "			WHERE recipe.IsDeleted ='false' ";

    public static List<Recipe> AnotherRecipe() throws SQLException {
        Connection cnn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        List<Recipe> recipeL = new ArrayList<>();

        try {
            cnn = DBUtils.getConnection();
            ptm = cnn.prepareStatement(ALL_NAME);
            rs = ptm.executeQuery();
            while (rs.next()) {
                String name = rs.getString("Name");
                Recipe recipeD = RecipeDAO.searchRecipebyName(name);
                recipeL.add(recipeD);

            }

        } catch (Exception e) {
            System.out.println("Error in ALL Name ");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return recipeL;
    }

    private static final String RELATED_INGREDIENTS = "SELECT DISTINCT recipe.Name\n"
            + "FROM [dbo].[Recipe] recipe join [dbo].[IngredientRecipe] igreRecipe\n"
            + "on recipe.[ID] =igreRecipe.[RecipeID]\n"
            + "join [dbo].[Ingredient] igre\n"
            + "on igreRecipe.IngredientID = igre.ID\n"
            + "WHERE recipe.IsDeleted = 'False' and igre.Name = ?";

    public static List<Recipe> listRelate(int recipeID) throws SQLException {
        List<Recipe> listRecipe = new ArrayList<>();
        HashMap<Integer, String> relateListRecipe = new HashMap<>();
        Connection cnn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        String secondElements = "";
        String thirdElements;
        RecipeDAO dao = new RecipeDAO();
        List<Ingredient> ingre = dao.listIngredient(recipeID);
        cnn = DBUtils.getConnection();
        int checkNum = 0;
        int checkNum1 = 0;
        List<Recipe> listF = new ArrayList<>();
        try {
            if (!ingre.isEmpty()) {
                for (int i = 1; i < ingre.size(); i++) {
                    secondElements += " OR igre.Name =" + "\'" + ingre.get(i).
                            getName() + "\'";
                }
                thirdElements = RELATED_INGREDIENTS + secondElements;
                ptm = cnn.prepareStatement(thirdElements);
                ptm.setString(1, ingre.get(0).getName());
            }
            if (ptm != null) {
                rs = ptm.executeQuery();
                while (rs.next()) {
                    relateListRecipe.put(checkNum, rs.getString("Name"));
                    Recipe recipeD = RecipeDAO.searchRecipebyName(relateListRecipe.get(checkNum));
                    if (recipeD != null && listRecipe.size() < 8) {
                        listRecipe.add(recipeD);
                        checkNum++;
                    }
                }
                checkNum1 =checkNum;
            }

            List<Recipe> recipeDL = RecipeDAO.RelatewithBaker(recipeID);
            for (int i = 0; i < recipeDL.size(); i++) {
                if (listRecipe.size() < 8) 
                listRecipe.add(recipeDL.get(i));
            }

            List<Recipe> recipeAn = RecipeDAO.AnotherRecipe();
            for (int i = 0; i < recipeAn.size(); i++) {
                if (listRecipe.size() < 8) {
                    listRecipe.add(recipeAn.get(i));

                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return listRecipe;

    }

    private static final String SHOW_RECIPE_LIST = "SELECT [Recipe].ID, [Recipe].[Name], [Recipe].DatePost, [Recipe].LastDateEdit, [Recipe].IsDeleted, [Picture].Img, [Recipe].UserID, [User].LastName + ' ' + [User].FirstName AS UserName\n"
            + "            FROM [Recipe]\n"
            + "            JOIN [User] ON [Recipe].[UserID] = [User].ID\n"
            + "            JOIN [Picture] ON [Picture].RecipeID = [Recipe].ID\n"
            + "            WHERE [Picture].IsCover = 1 AND [Recipe].IsDeleted = 0\n";

    public static List<Recipe> showRecipeList() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(SHOW_RECIPE_LIST);
            rs = ps.executeQuery();
            List<Recipe> list = new ArrayList<>();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getTimestamp("DatePost"),
                        rs.getTimestamp("LastDateEdit"),
                        rs.getBoolean("IsDeleted"),
                        rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("UserName"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            System.out.println("showRecipeList Query Error!" + ex.
                    getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

    private static final String UPDATE_DELETE = "UPDATE Recipe\n"
            + "SET IsDeleted = 1\n"
            + "WHERE Recipe.[ID] = ?";

    public static boolean deleteRecipe(int id) throws SQLException, SQLException {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(UPDATE_DELETE);
            ps.setInt(1, id);
            ps.executeUpdate();
            return true;
        } catch (Exception ex) {
            System.out.println("Query Delete Recipe For User error!" + ex.getMessage());
        } finally {

            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return false;
    }

    private static final String SEARCH_EXACTLY = "SELECT recipe.[Name],[Description],[Like],recipe.ID\n"
            + "                   ,[DatePost],[LastDateEdit],[PrepTime],[CookTime]\n"
            + "                        [Save],[IsDeleted],[UserID],Comment,[Img],baker.FirstName +' '+baker.LastName as fullName\n"
            + "                        FROM[dbo].[Recipe] recipe join [dbo].[Picture] pic\n"
            + "            			on recipe.ID =pic.RecipeID\n"
            + "            			join [dbo].[User]  baker\n"
            + "            			on  baker.ID =recipe.UserID\n"
            + "                        WHERE recipe.Name =? and pic.IsCover ='True'  and recipe.IsDeleted = 'False'";

    public static Recipe searchRecipebyName(String recipeName) throws SQLException {
        Connection cnn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        Recipe recipe = null;
        try {
            cnn = DBUtils.getConnection();
            ptm = cnn.prepareStatement(SEARCH_EXACTLY);
            ptm.setString(1, recipeName);
            rs = ptm.executeQuery();
            while (rs.next()) {
                int ID = rs.getInt("ID");
                String fullName = rs.getString("fullName");
//                String img = rs.getString("Img");
                int comment = rs.getInt("Comment");
                int like = rs.getInt("Like");
                int save = rs.getInt("Save");
                String cakeName = rs.getString("Name");
                String cover = rs.getString("Img");
                Timestamp date = rs.getTimestamp("DatePost");
                recipe = new Recipe(ID, cakeName, like, comment, cover, fullName, date);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (cnn != null) {
                cnn.close();
            }
        }
        return recipe;
    }

    public static ArrayList<RecipeSearch> getRecipes() throws SQLException {
        String sql1 = "SELECT P.Img, R.ID, R.Name, R.[Like], R.Comment, R.DatePost, U.ID AS UserID, U.LastName + ' ' + U.FirstName AS Username \n"
                + "FROM Recipe R\n"
                + "INNER JOIN Picture P ON P.RecipeID = R.ID\n"
                + "INNER JOIN [User] U ON R.UserID = U.ID\n"
                + "WHERE P.IsCover = 1 AND R.IsDeleted = 0";
        String sql2 = "SELECT I.Name, I.Point\n"
                + "FROM IngredientRecipe IR\n"
                + "INNER JOIN Ingredient I ON I.ID = IR.IngredientID\n"
                + "WHERE IR.RecipeID = ?";
        ArrayList<RecipeSearch> list = new ArrayList<RecipeSearch>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql1);
            rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ID");
                HashMap<String, Integer> ingres = new HashMap<>();
                PreparedStatement ps2 = conn.prepareStatement(sql2);
                ps2.setInt(1, id);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    ingres.put(rs2.getString("Name"), rs2.getInt("Point"));
                }
                list.add(new RecipeSearch(rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getInt("Like"),
                        rs.getInt("Comment"),
                        rs.getTimestamp("DatePost"),
                        ingres, rs.getString("Img"),
                        rs.getInt("UserID"),
                        rs.getString("Username")));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public static List<Recipe> getRecommnedRecipes() throws SQLException {
        String sql = "SELECT TOP 5 R.ID, Name, [Like], P.Img\n"
                + "FROM Recipe R\n"
                + "JOIN Picture P On R.ID = P.RecipeID\n"
                + "WHERE DatePost > DATEADD(month, -1, GETDATE()) AND IsDeleted = 0 AND P.IsCover = 1\n"
                + "ORDER BY [Like] + [Save]*5 + [Comment]*2 DESC";
        ArrayList<Recipe> list = new ArrayList<Recipe>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Recipe recipe = new Recipe(rs.getInt("ID"), rs.getString("Name"), rs.getInt("Like"), rs.getString("Img"));
                list.add(recipe);
            }
            return list;
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return null;
    }

//    private static final String DELETE_RECIPE = "			UPDATE [dbo].[Recipe] \n"
//            + "			SET [IsDeleted] =1 \n"
//            + "			WHERE [dbo].[Recipe].ID =?";
//
//    public static boolean deleteRecipe(int recipeID) {
//        Connection cn = null;
//        PreparedStatement ptm = null;
////ResultSet rs = null;
//        boolean check = false;
//
//        try {
//            cn = DBUtils.getConnection();
//            ptm = cn.prepareStatement(DELETE_RECIPE);
//            ptm.setInt(1, recipeID);
//
//        } catch (Exception e) {
//            System.out.println("co loi o deleteRecipe");
//            e.printStackTrace();
//        } finally {
//
//            if (ptm != null) {
//                ptm.close();
//            }
//            if (cn != null) {
//                cn.close();
//            }
//
//        }
//
//        return check;
//    }
}
