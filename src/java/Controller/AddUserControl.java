/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Role;

/**
 *
 * @author anhbu
 */
public class AddUserControl extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddUserControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddUserControl at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        //processRequest(request, response);
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra trạng thái tài khoản
        boolean status = "true".equals(request.getParameter("status"));

        // Lấy roleID từ request
        int roleID = 0;
        try {
            roleID = Integer.parseInt(request.getParameter("roleID"));
        } catch (NumberFormatException e) {
            System.out.println("Invalid roleID: " + request.getParameter("roleID"));
        }

        HttpSession session = request.getSession();

        // Kiểm tra roleID hợp lệ
        if (roleID == 0) {
            session.setAttribute("errorMessage", "Please select a valid role!");
            response.sendRedirect("acc");
            return;
        }

        // Tạo đối tượng Role từ roleID
        Role role = new Role(roleID, ""); // Role chưa có roleName, chỉ có roleID

        AccountDAO dao = new AccountDAO();
        boolean isInserted = dao.addUser(username, password, role, status, "", "", null, "", "", "");

        if (isInserted) {
            session.setAttribute("Message", "User added successfully!");
        } else {
            session.setAttribute("Message", "Cannot add user! The username may already exist.");
        }

        response.sendRedirect("acc");
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
