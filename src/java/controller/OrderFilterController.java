/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
public class OrderFilterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LocationDAO locationDAO = new LocationDAO();
        ArrayList<Location> locationList = locationDAO.list();
        request.setAttribute("locationList", locationList);
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
        String currentFilter = (String) request.getSession().getAttribute("currentFilter");
        if (priceRange != null && priceRange.equals(currentFilter)) {
            request.getSession().removeAttribute("currentFilter");
            if (departure != null && destination != null && departureDate != null) {
                flights = flightDAO.search(departure, destination, departureDate);
            } else {
                flights = flightDAO.list();
            }
        } else if (priceRange != null) {
            request.getSession().setAttribute("currentFilter", priceRange);
            ArrayList<Flight> searchResults;
            if (departure != null && destination != null && departureDate != null) {
                searchResults = flightDAO.search(departure, destination, departureDate);
            } else searchResults = flightDAO.list();
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
            for (Flight flight : searchResults) {
                Ticket ticket = ticketDAO.getByFlightId(flight.getId());
                if (ticket != null && ticket.getSeat().getCompartment().getType().getPrice() >= minPrice && ticket.getSeat().getCompartment().getType().getPrice() <= maxPrice) {
                    flights.add(flight);
                }
            }
        } else {
            if (departure != null && destination != null && departureDate != null) {
                flights = flightDAO.search(departure, destination, departureDate);
            } else flights = flightDAO.list();
        }
        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getByFlightId(flight.getId());
            ticketMap.put(flight.getId(), ticket);
        }
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
