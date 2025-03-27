package controller;
import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.time.*;
import java.util.*;
import java.util.logging.*;
import model.*;
/**
 *
 * @author A A
 */
public class UpdateFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        FlightDAO dao = new FlightDAO();
        LocationDAO locationDAO = new LocationDAO();
        Flight f = dao.getFlightById(id);
        request.setAttribute("flight", f);
        ArrayList<Location> locationList = locationDAO.list();
        request.setAttribute("locationList", locationList);
        request.getRequestDispatcher("flight-update.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String airplane = request.getParameter("airplane");
            int departureId = Integer.parseInt(request.getParameter("departure"));
            int destinationId = Integer.parseInt(request.getParameter("destination"));
            int price = Integer.parseInt(request.getParameter("price"));
            
            AirplaneDAO ad = new AirplaneDAO();
            LocationDAO locationDAO = new LocationDAO();
            Flight f = new Flight();
            f.setId(id);
            f.setName(name);
            f.setCode(code);
            f.setAirplane(ad.get(airplane));
            f.setDeparture(locationDAO.getById(departureId));
            f.setDestination(locationDAO.getById(destinationId));

            String entryTimeStr = request.getParameter("entryTime");
            String startingTimeStr = request.getParameter("startingTime");
            String landingTimeStr = request.getParameter("landingTime");
            f.setEntryTime(LocalDateTime.parse(entryTimeStr));
            f.setStartingTime(LocalDateTime.parse(startingTimeStr));
            f.setLandingTime(LocalDateTime.parse(landingTimeStr));
            f.setPrice(price);

            validateFlight(f);
            FlightDAO dao = new FlightDAO();
            dao.update(f);
            response.sendRedirect("list-flight");
        } catch (Exception ex) {
            Logger.getLogger(UpdateFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
            try {
                String id = request.getParameter("id");
                FlightDAO dao = new FlightDAO();
                Flight f = dao.getFlightById(id);
                request.setAttribute("flight", f);

                LocationDAO locationDAO = new LocationDAO();
                ArrayList<Location> locationList = locationDAO.list();
                request.setAttribute("locationList", locationList);

                request.setAttribute("error", "Failed to update flight: " + ex.getMessage());
                request.getRequestDispatcher("flight-update.jsp").forward(request, response);
            } catch (Exception e) {
                Logger.getLogger(UpdateFlightServlet.class.getName()).log(Level.SEVERE, "Error handling validation failure", e);
                response.sendRedirect("list-flight?error=Update+failed");
            }
        }
    }

    private void validateFlight(Flight f) throws Exception {
        if (f.getStartingTime().isBefore(f.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (f.getLandingTime().isBefore(f.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
        if (f.getDeparture().getId() == f.getDestination().getId()) {
            throw new Exception("Departure and destination cannot be the same location");
        }
        if(f.getLandingTime().equals(f.getStartingTime())){
            throw new Exception("Landing time must not be equal to starting time");
        }
        if(f.getPrice() < 100000){
            throw new Exception("Price cannot smaller than 100.000");
        }
    }
}
