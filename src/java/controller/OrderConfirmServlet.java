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
        try {
            // Flight Information
            String flightId = request.getParameter("flightId");
            String ticketClass = request.getParameter("ticketClass");
            
            // Passenger Details
            String adult = request.getParameter("adult");
            String child = request.getParameter("child");
            String baby = request.getParameter("baby");
            
            // Get Flight Details
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            request.setAttribute("flight", flight);
            
            // Get Compartment Details
            CompartmentDAO compartmentDAO = new CompartmentDAO();
            List<Compartment> compartments = compartmentDAO.getCompartmentsByFlightId(flightId);
            request.setAttribute("compartments", compartments);
            
            // Ticket Class
            request.setAttribute("ticketClass", ticketClass);
            
            // Passenger Details
            int totalPassengers = 0;
            if (adult != null && !adult.isEmpty()) {
                totalPassengers += Integer.parseInt(adult);
                request.setAttribute("adult", adult);
            }
            if (child != null && !child.isEmpty()) {
                totalPassengers += Integer.parseInt(child);
                request.setAttribute("child", child);
            }
            if (baby != null && !baby.isEmpty()) {
                totalPassengers += Integer.parseInt(baby);
                request.setAttribute("baby", baby);
            }
            request.setAttribute("passengers", totalPassengers);
            
            TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
            CompartmentTypeDAO compartmentTypeDAO = new CompartmentTypeDAO();
            PassengerTypeDAO passengerTypeDAO = new PassengerTypeDAO();
            NationDAO nationDAO = new NationDAO();

            // Add attributes for dropdown selections
            request.setAttribute("ticketTypes", ticketTypeDAO.list());
            request.setAttribute("compartmentTypes", compartmentTypeDAO.list());
            request.setAttribute("passengerTypes", passengerTypeDAO.list());
            request.setAttribute("nations", nationDAO.list());
            
            // User Account Information
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/view/Login.jsp");
                return;
            }
            AccountDAO ad = new AccountDAO();
            String username = (String) request.getSession().getAttribute("user");
            Account a = ad.getAccountByUsername(username);
            if (a != null) {
                request.setAttribute("userName", a.getName());
                request.setAttribute("userPhone", a.getPhone());
                request.setAttribute("userCitizenID", a.getCitizenID());
                request.setAttribute("userEmail", a.getEmail());
            }
            request.getRequestDispatcher("order-confirm.jsp").forward(request, response);
        } catch (Exception ex) {
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "An error occurred. Please try again.");
            response.sendRedirect("Login.jsp");
        }
    }
}