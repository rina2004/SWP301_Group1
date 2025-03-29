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
import java.util.List;
import java.util.stream.Collectors;
import model.Ticket;

/**
 *
 * @author anhbu
 */
public class StaffTicketProcessing extends HttpServlet {

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
            out.println("<title>Servlet StaffTicketProcessing</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffTicketProcessing at " + request.getContextPath() + "</h1>");
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
        int page = 1;
        int recordsPerPage = 5;
        String pageParam = request.getParameter("page");
        String searchOrderPassengerId = request.getParameter("search");

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {
            }
        }

        TicketDAO ticketDAO = new TicketDAO();
        List<Ticket> processingOrders = ticketDAO.getCancelledOrProcessingTickets(page, recordsPerPage);

        // Kiểm tra nếu search có giá trị hợp lệ thì mới lọc
        if (searchOrderPassengerId != null && !searchOrderPassengerId.trim().isEmpty()) {
            processingOrders = processingOrders.stream()
                    .filter(ticket -> ticket.getOrderP().getId().equals(searchOrderPassengerId))
                    .collect(Collectors.toList());
            request.setAttribute("search", searchOrderPassengerId);
        } else {
            request.setAttribute("search", ""); // Đặt về rỗng để không lưu trạng thái tìm kiếm
        }

        int totalRecords = ticketDAO.getTotalCancelledOrProcessingTickets();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("processingOrders", processingOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("view/ListTicketProcessing.jsp").forward(request, response);
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
        String orderPID = request.getParameter("orderID");
        String action = request.getParameter("action");
        String page = request.getParameter("page");

        if (orderPID == null || action == null) {
            response.sendRedirect("staffTicketProcessing?page=" + page);
            return;
        }

        TicketDAO ticketDAO = new TicketDAO();
        OrderDAO orderDAO = new OrderDAO();

        if ("accept".equals(action)) {
            ticketDAO.updateTicketStatusByOrderPID(orderPID, "Cancelled");
        } else if ("reject".equals(action)) {
            ticketDAO.updateTicketStatusByOrderPID(orderPID, "Rejected");

            String orderId = orderDAO.getOrderIdByOrderPassengerId(orderPID);
            if (orderId != null && ticketDAO.hasOnlyCancelledTickets(orderId)) {
                orderDAO.updateOrderStatus(orderId, "Cancelled");
            }
        }

        // Load lại danh sách đơn hàng và hiển thị trang JSP
        int currentPage = (page != null) ? Integer.parseInt(page) : 1;
        int recordsPerPage = 5;

        List<Ticket> processingOrders = ticketDAO.getCancelledOrProcessingTickets(currentPage, recordsPerPage);
        int totalRecords = ticketDAO.getTotalCancelledOrProcessingTickets();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("processingOrders", processingOrders);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("view/ListTicketProcessing.jsp").forward(request, response);
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
