/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author anhbu
 */
public class CancelTicketController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        Account currentUser = (Account) session.getAttribute("acc");

        if (currentUser == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        String role = currentUser.getRole().getName();
        if (!role.equals("Staff")) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        String ticketId = request.getParameter("ticketId");
        if (ticketId == null || ticketId.trim().isEmpty()) {
            response.sendRedirect("view/OrderDetail.jsp"); 
            return;
        }

//        TicketDAO ticketDAO = new TicketDAO();
//        ticketDAO.cancelTicket(ticketId);
//
//        // Quay lại trang danh sách vé sau khi hủy thành công / thất bại
//        response.sendRedirect("view/OrderDetail.jsp");
    }
}
