package controller;
import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

public class OrderFlightController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/view/Login.jsp");
            return;
        }
        LocationDAO locationDAO = new LocationDAO();
        ArrayList<Location> locations = locationDAO.list();
        request.setAttribute("locations", locations);
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
        String passengers = request.getParameter("passengers");
        passengers = (passengers == null || passengers.isEmpty()) ? "1" : passengers;
        if (departure == null || destination == null || departureDate == null
                || departure.isEmpty() || destination.isEmpty() || departureDate.isEmpty()) {
            request.setAttribute("error", "Please fill in all required search fields.");
            request.getRequestDispatcher("/view/order-home.jsp").forward(request, response);
            return;
        }
        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();
        ArrayList<Flight> flights = flightDAO.search(departure, destination, departureDate);
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("passengers", passengers);
        request.setAttribute("list", flights);
        request.getRequestDispatcher("/view/order-result.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}