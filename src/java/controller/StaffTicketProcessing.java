/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
import jakarta.servlet.RequestDispatcher;
========
import dal.OrderDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
import java.io.IOException;
import java.io.PrintWriter;
========
import java.util.List;
import model.Ticket;
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java

/**
 *
 * @author DUCDA
 */
<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
public class atcSidebarController extends HttpServlet {
========
public class StaffTicketProcessing extends HttpServlet {
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java

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
<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
            out.println("<title>Servlet atcSidebarController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet atcSidebarController at " + request.getContextPath() + "</h1>");
========
            out.println("<title>Servlet StaffTicketProcessing</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffTicketProcessing at " + request.getContextPath() + "</h1>");
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java
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
<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
        String page = request.getParameter("page");

        if (page != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher(page);
            dispatcher.forward(request, response);
        } else {
            response.getWriter().write("Lỗi: Không tìm thấy trang!");
        }
========
        //processRequest(request, response);
        TicketDAO dao = new TicketDAO();
        List<Ticket> processingOrders = dao.getCancelledOrProcessingTickets();

        request.setAttribute("processingOrders", processingOrders);
        request.getRequestDispatcher("view/ListTicketProcessing.jsp").forward(request, response);
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java
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
<<<<<<<< HEAD:src/java/controller/atcSidebarController.java
        processRequest(request, response);
========
        //processRequest(request, response);
        String orderPID = request.getParameter("orderID");
        String action = request.getParameter("action");

        if (orderPID == null || action == null) {
            response.sendRedirect("view/ListTicketProcessing.jsp");
            return;
        }

        TicketDAO ticketDAO = new TicketDAO();
        OrderDAO orderDAO = new OrderDAO();

        if ("accept".equals(action)) {
            // Chấp nhận vé
            ticketDAO.updateTicketStatusByOrderPID(orderPID, "Cancelled");
        } else if ("reject".equals(action)) {
            // Hủy vé
            ticketDAO.updateTicketStatusByOrderPID(orderPID, "Rejected");

            // Lấy OrderID từ OrderPassengerID
            String orderId = orderDAO.getOrderIdByOrderPassengerId(orderPID);
            if (orderId != null && ticketDAO.hasOnlyCancelledTickets(orderId)) {
                orderDAO.updateOrderStatus(orderId, "Cancelled");
            }
        }

        // Load lại danh sách đơn hàng và chuyển hướng
        List<Ticket> processingOrders = ticketDAO.getCancelledOrProcessingTickets();
        request.setAttribute("processingOrders", processingOrders);
        request.getRequestDispatcher("view/ListTicketProcessing.jsp").forward(request, response);
>>>>>>>> H:src/java/controller/StaffTicketProcessing.java
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
