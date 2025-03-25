/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.LuggageDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.Ticket;

/**
 *
 * @author tungn
 */
public class OrderLuggage extends HttpServlet {

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
            out.println("<title>Servlet OrderLuggage</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderLuggage at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();

        if (session == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        String accountId = (String) session.getAttribute("Accid");

        if (accountId == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }


        TicketDAO dao = new TicketDAO();

        String id = request.getParameter("id");
        String type = dao.getTypeByID(id);
        request.setAttribute("type", type);
        request.setAttribute("id", id);
        request.setAttribute("accountid", accountId);

        request.getRequestDispatcher("view/OrderLuggage.jsp").forward(request, response);
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
        String customerID = request.getParameter("customerID");
        String ticketID = request.getParameter("ticketID");
        String type = request.getParameter("type");
        String luggagePackage = request.getParameter("luggagePackage");

        String[] part = luggagePackage.split(",");
        double weight = Double.parseDouble(part[0].trim());
        double price = Double.parseDouble(part[1].trim());

        
        LuggageDAO dao = new LuggageDAO();
        dao.addExtraLuggage(customerID, ticketID, type, weight, price);
        request.getRequestDispatcher("view/ListTicket.jsp").forward(request, response);
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
