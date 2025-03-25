package controller;
import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;
/**
 *
 * @author A A
 */
public class OrderFlightController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LocationDAO locationDAO = new LocationDAO();
        ArrayList<Location> locations = locationDAO.list();
        request.setAttribute("locations", locations);
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
        String passengers = request.getParameter("passengers");
        String travelClass = request.getParameter("class");

        if (departure == null || destination == null || departureDate == null
                || departure.isEmpty() || destination.isEmpty() || departureDate.isEmpty()) {
            request.getRequestDispatcher("order-home.jsp").forward(request, response);
            return;
        }

        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();
        
        ArrayList<Flight> flights = flightDAO.search(departure, destination, departureDate);

        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getByFlightId(flight.getId());
            if (ticket != null) {
                ticketMap.put(flight.getId(), ticket);
            }
        }
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("passengers", passengers);
        request.setAttribute("class", travelClass);
        request.setAttribute("list", flights);
        request.setAttribute("ticketMap", ticketMap);
        request.getRequestDispatcher("order-result.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}