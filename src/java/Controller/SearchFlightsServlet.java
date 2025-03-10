/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FlightDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class SearchFlightsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get search parameters
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
        String passengers = request.getParameter("passengers");
        String travelClass = request.getParameter("class");

        // Check if this is an initial load or a search request
        if (departure == null || destination == null || departureDate == null
                || departure.isEmpty() || destination.isEmpty() || departureDate.isEmpty()) {
            // If parameters are missing, show the search form
            request.getRequestDispatcher("order-home.jsp").forward(request, response);
            return;
        }

        // Initialize DAOs
        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();

        // Perform search
        ArrayList<Flight> flights = flightDAO.search(departure, destination, departureDate);

        // Create a map of tickets for each flight
        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getTicketByFlightId(flight.getId());
            if (ticket != null) {
                ticketMap.put(flight.getId(), ticket);
            }
        }

        // Set attributes for the JSP
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("passengers", passengers);
        request.setAttribute("class", travelClass);
        request.setAttribute("list", flights);
        request.setAttribute("ticketMap", ticketMap);

        // Forward to the results page
        request.getRequestDispatcher("flight-search-results.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
