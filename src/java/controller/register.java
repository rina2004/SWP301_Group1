/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author tungn
 */
@WebServlet(name = "register", urlPatterns = {"/register"})
public class register extends HttpServlet {

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
            out.println("<title>Servlet register</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet register at " + request.getContextPath() + "</h1>");
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
        String username = request.getParameter("username");
        String password = request.getParameter("pass");
        String password2 = request.getParameter("pass2");
        String name = request.getParameter("name");
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");

        AccountDAO acc = new AccountDAO();
        final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

        if (acc.checkUserNameExist(username)) {
            request.setAttribute("errorUsername", "Username is existed !!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (username.trim().isEmpty()) {
            request.setAttribute("errorUsername", "Username does not contain space, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (username.matches("[a-zA-Z0-9_]{5,16}")) {
            request.setAttribute("errorUsername", "Username invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (password.equals(password2)) {
            request.setAttribute("errorPassword", "Confirrm password not match, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (password.trim().isEmpty()) {
            request.setAttribute("errorPassword", "Password does not contain space, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (password.matches("^[a-zA-Z0-9]{8,16}$")) {
            request.setAttribute("errorPassword", "Password is invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (email.trim().isEmpty()) {
            request.setAttribute("errorEmail", "Password is invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (email.matches(EMAIL_REGEX)) {
            request.setAttribute("errorEmail", "Email is invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (acc.checkEmailExist(email)) {
            request.setAttribute("errorEmail", "Email is existed !!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("pass", password);
            session.setAttribute("pass2", password2);
            session.setAttribute("name", name);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            session.setAttribute("dob", dob);
            session.setAttribute("address", address);

            String otp = JavaEmail.createOTP();
            JavaEmail.sendOtpEmail(email, otp);
            session.setAttribute("otp", otp);
            session.setAttribute("timeOtp", System.currentTimeMillis() + 2 * 60 * 1000);
            response.sendRedirect("Otp.jsp");
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
