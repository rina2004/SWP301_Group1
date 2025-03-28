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
        
        CompartmentTypeDAO ctd = new CompartmentTypeDAO();
        ArrayList<CompartmentType> cts = ctd.list();
        request.setAttribute("cts", cts);
        
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");
//        String compartmentType = request.getParameter("compartmentType");
        String passengers = request.getParameter("passengers");
        
        passengers = (passengers == null || passengers.isEmpty()) ? "1" : passengers;
//        compartmentType = (compartmentType == null || compartmentType.isEmpty()) ? "e" : compartmentType;
        
        if (departure == null || destination == null || departureDate == null
                || departure.isEmpty() || destination.isEmpty() || departureDate.isEmpty()) {
            request.setAttribute("error", "Please fill in all required search fields.");
            request.getRequestDispatcher("/view/order-home.jsp").forward(request, response);
            return;
        }
        FlightDAO flightDAO = new FlightDAO();
        ArrayList<Flight> flights = flightDAO.search(departure, destination, departureDate);
//        ArrayList<Flight> flights = flightDAO.searchTest(departure, destination, departureDate, compartmentType);
        
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);
        request.setAttribute("passengers", passengers);
        request.setAttribute("adult", request.getParameter("adult"));
        request.setAttribute("child", request.getParameter("child"));
        request.setAttribute("baby", request.getParameter("baby"));
        request.setAttribute("list", flights);
        request.getRequestDispatcher("/view/order-result.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
