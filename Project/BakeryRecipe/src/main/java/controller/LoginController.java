/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.UserDAO;
import dto.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdk.nashorn.internal.ir.ContinueNode;
import stackjava.com.accessgoogle.common.GooglePojo;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "login.jsp";
    private static final String ADMIN = "admin";
    private static final String ADMIN_PAGE = "AdminDashBoard";
    private static final String US = "baker";
    private static final String USER_PAGE = "home";

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
        String url = ERROR;
        User loginUser = null;
        HttpSession session = request.getSession();
        try {
            String code = request.getParameter("code");
            //check if user is not login with google
            if (code == null || code.isEmpty()) {
                String email = request.getParameter("email");
                String password = (String) request.getAttribute("password");

                //set user password to ""
                loginUser = UserDAO.login(email, password);
//                System.out.println("Login normal" + loginUser);
                if (loginUser == null) {
                    request.setAttribute("LOGIN_ERROR", "Login Failed! Wrong email or Password");
                }
            } else {
                //login with google
                loginUser = (User) request.getAttribute("LOGIN_USER");
//                System.out.println("Login Google" + loginUser);
            }
        } catch (Exception e) {
            log("Error at LoginController" + e.toString());
        } finally {
            //this validation is only for people login with password
            if (loginUser != null && request.getAttribute("LOGIN_ERROR") == null) {
                String roleID = loginUser.getRole();
                Boolean isActive = loginUser.isIsActive();
                if (isActive == false) {
                    request.setAttribute("LOGIN_ERROR", "You have been banned");
                } else {
                    if (ADMIN.equalsIgnoreCase(roleID)) {
                        url = ADMIN_PAGE;
                    } else if (US.equalsIgnoreCase(roleID)) {
                        url = USER_PAGE;
                    }
                    session.setAttribute("login", loginUser);
                    response.sendRedirect(url);
                    return;
                }
            }
            request.getRequestDispatcher(url).forward(request, response);
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
        request.getRequestDispatcher(ERROR).forward(request, response);
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
