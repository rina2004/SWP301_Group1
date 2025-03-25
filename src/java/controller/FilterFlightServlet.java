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
import java.util.*;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class FilterFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String priceRange = request.getParameter("priceRange");
        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();
        ArrayList<Flight> flights = new ArrayList<>();
        
        // Check if we should toggle filter or apply it
        String currentFilter = (String) request.getSession().getAttribute("currentFilter");
        
        if (priceRange != null && priceRange.equals(currentFilter)) {
            // If clicking the same filter again, clear the filter
            request.getSession().removeAttribute("currentFilter");
            flights = flightDAO.list(); 
        } else if (priceRange != null) {
            request.getSession().setAttribute("currentFilter", priceRange);
            flights = switch (priceRange) {
                case "cheapest" -> flightDAO.getFlightsByPriceRange(0, 199999);
                case "best" -> flightDAO.getFlightsByPriceRange(200000, 1000000);
                case "quickest" -> flightDAO.getFlightsByPriceRange(1000001, Double.MAX_VALUE);
                default -> flightDAO.list();
            };
        } else {
            flights = flightDAO.list();
        }
        
        // Create a map of tickets for each flight
        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getTicketByFlightId(flight.getId());
            ticketMap.put(flight.getId(), ticket);
        }
        
        request.setAttribute("list", flights);
        request.setAttribute("ticketMap", ticketMap);
        request.setAttribute("activeFilter", priceRange);
        request.getRequestDispatcher("flight-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}