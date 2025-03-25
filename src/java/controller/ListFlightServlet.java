/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.FlightDAO;
import dal.TicketDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class ListFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FlightDAO dao = new FlightDAO();
        ArrayList<Flight> list = null;
        try {
            list = dao.list();
            TicketDAO ticketDao = new TicketDAO();
            Map<String, Ticket> ticketMap = new HashMap<>();
            for (Flight flight : list) {
                Ticket ticket = ticketDao.getTicketByFlightId(flight.getId());
                ticketMap.put(flight.getId(), ticket);
            }
            request.setAttribute("ticketMap", ticketMap);
            request.setAttribute("list", list);
            request.getRequestDispatcher("flight-list.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ListFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
