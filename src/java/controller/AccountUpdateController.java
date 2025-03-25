/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
<<<<<<<< HEAD:src/java/controller/AccountUpdateController.java
========

>>>>>>>> main:src/java/controller/EditAccountControl.java
package controller;

import dal.AccountDAO;
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
 * @author anhbu
 */
<<<<<<<< HEAD:src/java/controller/AccountUpdateController.java
public class AccountUpdateController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
========
@WebServlet(name="EditAccountControl", urlPatterns={"/editAccount"})
public class EditAccountControl extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
>>>>>>>> main:src/java/controller/EditAccountControl.java
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String id = request.getParameter("id");
        String password = request.getParameter("password");
     
        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        
        AccountDAO dao = new AccountDAO();
        dao.updateAccount(id, password, status);
        response.sendRedirect("acc");
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
<<<<<<<< HEAD:src/java/controller/AccountUpdateController.java
            throws ServletException, IOException {
        //processRequest(request, response);
        String id = request.getParameter("uid");
        AccountDAO dao = new AccountDAO();
        Account u = dao.getUserByID(id);

        request.setAttribute("updateAccount", u);
        request.getRequestDispatcher("view/Editaccount.jsp").forward(request, response);
       
    }
========
    throws ServletException, IOException {
        processRequest(request, response);
    } 
>>>>>>>> main:src/java/controller/EditAccountControl.java

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
<<<<<<<< HEAD:src/java/controller/AccountUpdateController.java
            throws ServletException, IOException {
        //processRequest(request, response);
         String id = request.getParameter("id");
        String password = request.getParameter("password");

        boolean status = Boolean.parseBoolean(request.getParameter("status"));

        AccountDAO dao = new AccountDAO();
        dao.updateAccount(id, password, status);
        response.sendRedirect("account-list");
========
    throws ServletException, IOException {
        processRequest(request, response);
>>>>>>>> main:src/java/controller/EditAccountControl.java
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
