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
import java.sql.*;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Airplane;
import model.Flight;
import model.Location;

/**
 *
 * @author A A
 */
public class AddFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirplaneDAO airplaneDao = new AirplaneDAO();
        List<Airplane> airplaneList;
        airplaneList = airplaneDao.list();
        LocationDAO locationDao = new LocationDAO();
        List<Location> locationList = locationDao.list();

        Collections.sort(locationList, (Location l1, Location l2) -> l1.getName().compareToIgnoreCase(l2.getName()));

        request.setAttribute("airplanes", airplaneList);
        request.setAttribute("locations", locationList);
        request.getRequestDispatcher("flight-form.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            AirplaneDAO ad = new AirplaneDAO();
            LocationDAO ld = new LocationDAO();

            Flight f = new Flight();
            f.setId(generateFlightId());
            f.setName(request.getParameter("name"));
            f.setCode(generateFlightCode());

            f.setAirplaneID(ad.get(request.getParameter("airplaneID")));

            // Get Location objects based on selected IDs
            int departureId = Integer.parseInt(request.getParameter("departure"));
            int destinationId = Integer.parseInt(request.getParameter("destination"));
            f.setDeparture(ld.getById(departureId));
            f.setDestination(ld.getById(destinationId));

            f.setEntryTime(LocalDateTime.parse(request.getParameter("entryTime")));
            f.setStartingTime(LocalDateTime.parse(request.getParameter("startingTime")));
            f.setLandingTime(LocalDateTime.parse(request.getParameter("landingTime")));

            validateFlight(f);

            FlightDAO dao = new FlightDAO();
            dao.insert(f);

            response.sendRedirect("list-flight");

        } catch (Exception e) {
            request.setAttribute("error", "Error adding flight: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String generateFlightId() throws Exception {
        FlightDAO dao = new FlightDAO();
        // Get highest current flight ID number
        String highestId = dao.getHighestFlightId();

        if (highestId == null) {
            // If no flights exist, start with FL001
            return "FL001";
        } else {
            // Extract the numeric part
            String numericPart = highestId.substring(2); // Remove "FL"
            int nextNumber = Integer.parseInt(numericPart) + 1;
            // Format with leading zeros (e.g., FL001, FL002, etc.)
            return String.format("FL%03d", nextNumber);
        }
    }

    private String generateFlightCode() throws Exception {
        FlightDAO dao = new FlightDAO();
        // Get highest current flight code number
        String highestCode = dao.getHighestFlightCode();

        if (highestCode == null) {
            // If no flights exist, start with VN001
            return "VN001";
        } else {
            // Extract the numeric part
            String numericPart = highestCode.substring(2); // Remove "VN"
            int nextNumber = Integer.parseInt(numericPart) + 1;
            // Format with leading zeros (e.g., VN001, VN002, etc.)
            return String.format("VN%03d", nextNumber);
        }
    }

    private void validateFlight(Flight flight) throws Exception {
        FlightDAO dao = new FlightDAO();

        if (dao.getFlightByName(flight.getName()) != null) {
            throw new Exception("Flight name already exists.");
        }

        if (flight.getName() == null || flight.getName().trim().isEmpty()) {
            throw new Exception("Flight name is required");
        }

        if (flight.getDeparture().getId() == flight.getDestination().getId()) {
            throw new Exception("Departure and destination cannot be the same location");
        }

        if (flight.getStartingTime().isBefore(flight.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (flight.getLandingTime().isBefore(flight.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
    }
}
