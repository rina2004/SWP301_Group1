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
public class SearchFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        
        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();
        
        ArrayList<Flight> flights;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            flights = flightDAO.searchFlightsByName(searchTerm);
        } else {
            flights = flightDAO.list();
        }
        
        Map<String, Ticket> ticketMap = new HashMap<>();
        for (Flight flight : flights) {
            Ticket ticket = ticketDAO.getByFlightId(flight.getId());
            ticketMap.put(flight.getId(), ticket);
        }
        
        request.setAttribute("list", flights);
        request.setAttribute("ticketMap", ticketMap);
        request.setAttribute("searchTerm", searchTerm); 
        
        request.getRequestDispatcher("flight-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}