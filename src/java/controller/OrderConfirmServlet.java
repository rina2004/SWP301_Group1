package controller;
import dal.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;
/**
 *
 * @author A A
 */
public class OrderConfirmServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String flightId = request.getParameter("flightId");
            String ticketClass = request.getParameter("ticketClass");
            String passengers = request.getParameter("passengers");
            String orderId = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            HttpSession session = request.getSession();
            CompartmentDAO cd = new CompartmentDAO();
            ArrayList<Compartment> list = cd.getCompartmentsByFlightId(flightId);
            session.setAttribute("compartments", list);
            session.setAttribute("orderId", orderId);
            session.setAttribute("flight", flight);
            session.setAttribute("ticketClass", ticketClass);
            session.setAttribute("passengers", passengers);
            response.sendRedirect("order-confirm.jsp");
        } catch (Exception ex) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "An error occurred during booking. Please try again.");
            response.sendRedirect("order");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
