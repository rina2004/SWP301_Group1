/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirplaneDAO;
import dal.FlightDAO;
import dal.LocationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;
import model.Location;

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
            String airplaneID = request.getParameter("airplaneID");

            // Get location IDs from form
            int departureId = Integer.parseInt(request.getParameter("departure"));
            int destinationId = Integer.parseInt(request.getParameter("destination"));

            AirplaneDAO ad = new AirplaneDAO();
            LocationDAO locationDAO = new LocationDAO();

            Flight f = new Flight();
            f.setId(id);
            f.setName(name);
            f.setCode(code);
            f.setAirplaneID(ad.get(airplaneID));

            // Set locations using the IDs
            f.setDeparture(locationDAO.getById(departureId));
            f.setDestination(locationDAO.getById(destinationId));

            String entryTimeStr = request.getParameter("entryTime");
            String startingTimeStr = request.getParameter("startingTime");
            String landingTimeStr = request.getParameter("landingTime");

            f.setEntryTime(LocalDateTime.parse(entryTimeStr));
            f.setStartingTime(LocalDateTime.parse(startingTimeStr));
            f.setLandingTime(LocalDateTime.parse(landingTimeStr));

            validateFlight(f);

            FlightDAO dao = new FlightDAO();
            dao.update(f);

            response.sendRedirect("list-flight");
        } catch (Exception ex) {
            Logger.getLogger(UpdateFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
            try {
                // Get the flight ID from the request
                String id = request.getParameter("id");
                FlightDAO dao = new FlightDAO();

                // Retrieve the flight again
                Flight f = dao.getFlightById(id);
                request.setAttribute("flight", f);

                // Get all locations for the dropdown lists
                LocationDAO locationDAO = new LocationDAO();
                ArrayList<Location> locationList = locationDAO.list();
                request.setAttribute("locationList", locationList);

                // Set the error message
                request.setAttribute("error", "Failed to update flight: " + ex.getMessage());

                // Forward to the JSP page
                request.getRequestDispatcher("flight-update.jsp").forward(request, response);
            } catch (Exception e) {
                // Log any errors that occur during error handling
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
    }
}
