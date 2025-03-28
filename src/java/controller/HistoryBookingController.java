/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Order;
import model.OrderPassenger;
import model.Ticket;


/**
 *
 * @author anhbu
 */
public class HistoryBookingController extends HttpServlet {

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
            out.println("<title>Servlet HistoryBookingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HistoryBookingController at " + request.getContextPath() + "</h1>");
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
        // Lấy accountId từ session
         HttpSession session = request.getSession();
    Account acc = (Account) session.getAttribute("acc");

    if (acc == null) {
        response.sendRedirect("view/Login.jsp");
        return;
    }

    String accountId = acc.getId();
    OrderDAO orderDAO = new OrderDAO();
    TicketDAO ticketDAO = new TicketDAO();

    // Lấy danh sách Order của tài khoản này
    List<Order> orders = orderDAO.getOrderHistory(accountId);

    // Map chứa danh sách hành khách theo từng Order
    Map<String, List<OrderPassenger>> passengersByOrder = new HashMap<>();
    
    // Map chứa danh sách vé theo từng OrderPassenger
    Map<String, List<Ticket>> ticketsByPassenger = new HashMap<>();

    for (Order order : orders) {
        // Lấy danh sách hành khách của Order này
        List<OrderPassenger> passengers = orderDAO.getPassengersByOrderId(order.getId());
        passengersByOrder.put(order.getId(), passengers);

        for (OrderPassenger passenger : passengers) {
            // Lấy danh sách vé theo PassengerId
            List<Ticket> tickets = ticketDAO.getTicketsByPassengerId(passenger.getId());
            ticketsByPassenger.put(passenger.getId(), tickets);
        }
    }

    // Đẩy dữ liệu lên JSP
    request.setAttribute("orders", orders);
    request.setAttribute("passengersByOrder", passengersByOrder);
    request.setAttribute("ticketsByPassenger", ticketsByPassenger);
    request.getRequestDispatcher("view/HistoryBooking.jsp").forward(request, response);
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
