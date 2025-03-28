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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LocationDAO locationDAO = new LocationDAO();
        ArrayList<Location> locationList = locationDAO.list();
        request.setAttribute("locationList", locationList);

        String priceRange = request.getParameter("priceRange");
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
        String sortOrder = request.getParameter("order");
        
        if (departure == null) departure = (String) request.getSession().getAttribute("departure");
        if (destination == null) destination = (String) request.getSession().getAttribute("destination");
        if (departureDate == null) departureDate = (String) request.getSession().getAttribute("departureDate");
        request.getSession().setAttribute("departure", departure);
        request.getSession().setAttribute("destination", destination);
        request.getSession().setAttribute("departureDate", departureDate);
        
        FlightDAO flightDAO = new FlightDAO();
        TicketDAO ticketDAO = new TicketDAO();
        ArrayList<Flight> flights;
        
        if (departure != null && destination != null && departureDate != null) {
            flights = flightDAO.orderResultSort(departure, destination, departureDate, sortOrder);
        } else {
            flights = flightDAO.list();
        }
       
        request.setAttribute("list", flights);
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("sortOrder", sortOrder);
        request.getRequestDispatcher("order-result.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
