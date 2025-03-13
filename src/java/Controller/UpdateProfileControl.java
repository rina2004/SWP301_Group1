/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import model.Account;

/**
 *
 * @author anhbu
 */
public class UpdateProfileControl extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfileControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileControl at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");

        if (acc == null) {
            request.setAttribute("error", "You must be logged in to edit your profile.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        request.setAttribute("account", acc);
        request.getRequestDispatcher("view/Profileaccount.jsp").forward(request, response);
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
        // Lấy dữ liệu từ form
        HttpSession session = request.getSession();

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String citizenID = request.getParameter("citizenID");
        String dobStr = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");

        // Kiểm tra dữ liệu hợp lệ
        String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        String phonePattern = "^[0-9]{10,11}$";
        String citizenIDPattern = "^[0-9]{9,12}$";

        if (!email.matches(emailPattern)) {
            session.setAttribute("error", "Invalid email format!");
            response.sendRedirect("profile");
            return;
        }

        if (!phone.matches(phonePattern)) {
            session.setAttribute("error", "Phone number must be 10-11 digits!");
            response.sendRedirect("profile");
            return;
        }

        if (!citizenID.matches(citizenIDPattern)) {
            session.setAttribute("error", "Citizen ID must be 9-12 digits!");
            response.sendRedirect("profile");
            return;
        }

        // Chuyển đổi ngày sinh từ String -> java.sql.Date
        Date dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                sdf.setLenient(false);
                java.util.Date utilDate = sdf.parse(dobStr);
                dob = new Date(utilDate.getTime()); // Chuyển thành java.sql.Date
            } catch (ParseException e) {
                session.setAttribute("error", "Invalid date format!");
                response.sendRedirect("profile");
                return;
            }
        }

        // Lấy tài khoản từ session
        Account acc = (Account) session.getAttribute("acc");

        if (acc != null) {
            // Cập nhật thông tin tài khoản
            acc.setName(name);
            acc.setCitizenID(citizenID);
            acc.setDob(dob);
            acc.setPhone(phone);
            acc.setAddress(address);
            acc.setEmail(email);

            // Gọi DAO để cập nhật database
            AccountDAO dao = new AccountDAO();
            dao.updateProfile(acc); // Đảm bảo phương thức này cập nhật theo userID

            // Lấy lại thông tin mới từ database
            Account updatedAcc = dao.getUserByID(acc.getId());
            session.setAttribute("acc", updatedAcc); // Cập nhật lại session với thông tin mới

            session.setAttribute("success", "Profile updated successfully!");
            response.sendRedirect("profile");
        } else {
            session.setAttribute("error", "Unauthorized update attempt!");
            response.sendRedirect("profile");
        }
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
