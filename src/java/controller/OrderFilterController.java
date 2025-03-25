/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.FlightDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class OrderFilterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String priceRange = request.getParameter("priceRange");
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");

        if (departure == null) {
            departure = (String) request.getSession().getAttribute("departure");
        }
        if (destination == null) {
            destination = (String) request.getSession().getAttribute("destination");
        }
        if (departureDate == null) {
            departureDate = (String) request.getSession().getAttribute("departureDate");
        }

        request.getSession().setAttribute("departure", departure);
        request.getSession().setAttribute("destination", destination);
        request.getSession().setAttribute("departureDate", departureDate);

        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();

        ArrayList<Flight> flights;

        // Check if we should toggle filter or apply it
        String currentFilter = (String) request.getSession().getAttribute("currentFilter");

        if (priceRange != null && priceRange.equals(currentFilter)) {
            // If clicking the same filter again, clear the filter
            request.getSession().removeAttribute("currentFilter");

            // Get flights matching original search criteria without price filter
            if (departure != null && destination != null && departureDate != null) {
                flights = flightDAO.search(departure, destination, departureDate);
            } else {
                flights = flightDAO.list();
            }
        } else if (priceRange != null) {
            // Store current filter in session
            request.getSession().setAttribute("currentFilter", priceRange);

            // First, get flights matching search criteria
            ArrayList<Flight> searchResults;
            if (departure != null && destination != null && departureDate != null) {
                searchResults = flightDAO.search(departure, destination, departureDate);
            } else {
                searchResults = flightDAO.list();
            }

            // Then apply price filter to those results
            flights = new ArrayList<>();
            double minPrice = 0;
            double maxPrice = Double.MAX_VALUE;

            switch (priceRange) {
                case "cheapest":
                    maxPrice = 199999;
                    break;
                case "best":
                    minPrice = 200000;
                    maxPrice = 1000000;
                    break;
                case "quickest":
                    minPrice = 1000001;
                    break;
            }

            // Filter searchResults based on price range
            for (Flight flight : searchResults) {
                Ticket ticket = ticketDAO.getByFlightId(flight.getId());
                if (ticket != null && ticket.getSeat().getCompartment().getType().getPrice() >= minPrice && ticket.getSeat().getCompartment().getType().getPrice() <= maxPrice) {
                    flights.add(flight);
                }
            }
        } else {
            // If no filter specified, get flights matching search criteria
            if (departure != null && destination != null && departureDate != null) {
                flights = flightDAO.search(departure, destination, departureDate);
            } else {
                flights = flightDAO.list();
            }
        }

        // Create a map of tickets for each flight
        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getByFlightId(flight.getId());
            ticketMap.put(flight.getId(), ticket);
        }

        // Set attributes for JSP
        request.setAttribute("list", flights);
        request.setAttribute("ticketMap", ticketMap);
        request.setAttribute("activeFilter", priceRange);
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);

        request.getRequestDispatcher("order-result.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
