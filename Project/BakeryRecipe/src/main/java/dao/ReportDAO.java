/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Report;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author VO MINH MAN
 */
public class ReportDAO {

    private static final String ADD_REPORT_RECIPE = "insert into [dbo].[ReportRecipe]([DateReport],[Detail],[RecipeID],[UserID],[ReportType]) "
            + "values (?,?,?,?,?)";

    public static boolean addReport(int bakerID, int recipeID, String detail, String reportType) throws SQLException {
        Connection cnn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        boolean check = false;
        int random_int = (int) Math.floor(Math.random() * (100 - 1 + 1) + 1);
        Date currentDate = new Date(System.currentTimeMillis());
        SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
        String date = dateFormat.format(currentDate);
        try {
            cnn = DBUtils.getConnection();
            ptm = cnn.prepareCall(ADD_REPORT_RECIPE);

            ptm.setString(1, date);
            ptm.setString(2, detail);
            ptm.setInt(3, recipeID);
            ptm.setInt(4, bakerID);
            ptm.setString(5, reportType);
            check = ptm.executeUpdate() > 0 ? true : false;

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
        return check;
    }

    private static final String ADD_REPORT_COMMENT = "insert into [dbo].[ReportComment]([DateReport],"
            + "[Detail],[CommentID],[UserID]) values (?,?,?,?)";

    public static boolean reportCMT(String detailCMT, int CommentID, int userID) throws SQLException {
        Connection cn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        Date currentDate = new Date(System.currentTimeMillis());
        SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
        String date = dateFormat.format(currentDate);
        try {
            cn = DBUtils.getConnection();
            ptm = cn.prepareStatement(ADD_REPORT_COMMENT);
            ptm.setString(1, date);
            ptm.setString(2, detailCMT);
            ptm.setInt(3, CommentID);
            ptm.setInt(4, userID);
            check = ptm.executeUpdate() > 0 ? true : false;
        } catch (Exception e) {
        } finally {

            if (ptm != null) {
                ptm.close();
            }
            if (cn != null) {
                cn.close();
            }
        }
        return check;
    }

    private static final String SHOW_REPORT_COMM_LIST = "SELECT [ReportComment].ID, [ReportComment].Detail, "
            + "[ReportComment].DateReport, [ReportComment].ReportType, "
            + "[ReportComment].[Status], [ReportComment].CommentID, "
            + "[ReportComment].UserID, [User].LastName + ' ' + [User].FirstName AS Reporter, "
            + "[Comment].Comment\n"
            + "FROM [ReportComment]\n"
            + "JOIN [User] ON [ReportComment].UserID = [User].ID\n"
            + "JOIN [Comment] ON [Comment].ID = [ReportComment].CommentID";

    public static List<Report> reportCMTList() throws SQLException {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(SHOW_REPORT_COMM_LIST);
            rs = ps.executeQuery();
            List<Report> list = new ArrayList<>();
            while (rs.next()) {
                Report reportCMT = new Report(rs.getInt("ID"),
                        rs.getDate("DateReport"),
                        rs.getString("Detail"),
                        rs.getInt("UserID"),
                        rs.getString("ReportType"),
                        rs.getString("Status"),
                        rs.getString("Reporter"),
                        rs.getString("Comment"),
                        rs.getInt("CommentID"));
                list.add(reportCMT);
            }
            return list;
        } catch (Exception ex) {
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

}
