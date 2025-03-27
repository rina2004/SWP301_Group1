/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.List;
import model.*;
/**
 *
 * @author anhbu
 */
public class HistoryBookingController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        // Lấy accountId từ session
        HttpSession session = request.getSession();
        Account acc = (Account) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        String accountId = acc.getId(); // hoặc acc.getAccountId() nếu tên là như vậy trong model của bạn

        OrderDAO orderDAO = new OrderDAO();
//        List<Order> orders = orderDAO.getOrderHistory(accountId);
//        request.setAttribute("orders", orders);
        request.getRequestDispatcher("view/HistoryBooking.jsp").forward(request, response);
    }

}
