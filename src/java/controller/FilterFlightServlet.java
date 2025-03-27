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
public class FilterFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String priceRange = request.getParameter("priceRange");
        FlightDAO flightDAO = new FlightDAO();
        ArrayList<Flight> flights = new ArrayList<>();
        String currentFilter = (String) request.getSession().getAttribute("currentFilter");
        if (priceRange != null && priceRange.equals(currentFilter)) {
            request.getSession().removeAttribute("currentFilter");
            flights = flightDAO.list();
        } else if (priceRange != null) {
            request.getSession().setAttribute("currentFilter", priceRange);
            flights = flightDAO.filterFlightsByPrice(priceRange);
        } else {
            flights = flightDAO.list();
        }
        request.setAttribute("list", flights);
        request.setAttribute("activeFilter", priceRange);
        request.getRequestDispatcher("flight-list.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
