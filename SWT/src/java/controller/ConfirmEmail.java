/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author tungn
 */
public class ConfirmEmail extends HttpServlet {

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
            out.println("<title>Servlet ConfirmEmail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmEmail at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        String otp = request.getParameter("otp");
        String otpStore = (String) session.getAttribute("otp");

        if (otp == null || !otp.equals(otpStore)) {
            request.setAttribute("otpInvalid", "Mã OTP không hợp lệ, vui lòng thử lại!!!");
            request.getRequestDispatcher("view/OTP.jsp").forward(request, response);
            return;
        }

        session.removeAttribute("otp");
        session.removeAttribute("timeOtp");

        String username = (String) session.getAttribute("username");
        String password = (String) session.getAttribute("pass");
        String fullname = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email");
        String phone = (String) session.getAttribute("phone");
        String dobString = (String) session.getAttribute("dob");
        String address = (String) session.getAttribute("address");

        if (username == null || password == null || fullname == null || email == null) {
            request.setAttribute("error", "Dữ liệu đăng ký bị thiếu, vui lòng thử lại!");
            request.getRequestDispatcher("view/OTP.jsp").forward(request, response);
            return;
        }

        AccountDAO dao = new AccountDAO();

        try {
            java.sql.Date dob = null;
            if (dobString != null && !dobString.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = sdf.parse(dobString);
                dob = new java.sql.Date(parsedDate.getTime());
            }
            dao.register(username, password, fullname, dob, phone, address, email);
            session.invalidate();
            response.sendRedirect("view/Login.jsp");

        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorDob", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("view/OTP.jsp").forward(request, response);
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
