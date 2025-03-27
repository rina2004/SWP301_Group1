package controller;
import dal.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;
public class OrderConfirmServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String flightId = request.getParameter("flightId");
            String ticketClass = request.getParameter("ticketClass");
            String passengerName = request.getParameter("firstName");
            String dob = request.getParameter("dob");
            String nationality = request.getParameter("nationality");
            String price = request.getParameter("price");
            String bookingReference = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            HttpSession session = request.getSession();
            session.setAttribute("passengerName", passengerName);
            session.setAttribute("bookingReference", bookingReference);
            session.setAttribute("totalAmount", price + " VND");
            request.getRequestDispatcher("order-success.jsp").forward(request, response);
        } catch (Exception ex) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "An error occurred during booking. Please try again.");
            response.sendRedirect("order");
        }
    }
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String flightId = request.getParameter("flightId");
    String ticketClass = request.getParameter("ticketClass");
    String passengers = request.getParameter("passengers");

    FlightDAO flightDAO = new FlightDAO();
    Flight flight = flightDAO.getFlightById(flightId);
    
    request.setAttribute("flight", flight);
    request.setAttribute("ticketClass", ticketClass);
    request.setAttribute("passengers", passengers);

    // You might also want to fetch and set compartments
    CompartmentDAO compartmentDAO = new CompartmentDAO();
    List<Compartment> compartments = compartmentDAO.getCompartmentsByFlightId(flightId);
    request.setAttribute("compartments", compartments);

    request.getRequestDispatcher("order-confirm.jsp").forward(request, response);
}
}