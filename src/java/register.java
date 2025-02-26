/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author tungn
 */
@WebServlet(urlPatterns = {"/register"})
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

        DAO dao = new DAO();

        if (!password.equals(password2)) {
            request.setAttribute("error", "Confirm password not correct!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (dao.checkAccountExist(username)) {
            request.setAttribute("errorExistUsername", "Username is existed, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (username.trim().isEmpty()){
            request.setAttribute("errorUsername", "Username does not contain space, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (password.trim().isEmpty()) {
            request.setAttribute("errorPassword", "Password does not contain space, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else if(username.matches("^[a-zA-Z0-9_]{5,16}$")){
            request.setAttribute("invalidUsername", "Username is invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else if(password.matches("^[a-zA-Z0-9]{8,16}$")){
            request.setAttribute("invalidPassword", "Password is invalid, try again!!!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }else{
             dao.register(username, password);
             response.sendRedirect("login.jsp");
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
