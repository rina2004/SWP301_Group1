/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.time.*;
import java.util.*;
import model.*;
/**
 *
 * @author A A
 */
public class AddFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirplaneDAO ad = new AirplaneDAO();
        List<Airplane> airplaneList = ad.list();
        LocationDAO ld = new LocationDAO();
        List<Location> locationList = ld.list();

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
            f.setAirplane(ad.get(request.getParameter("airplane")));
            int departureId = Integer.parseInt(request.getParameter("departure"));
            int destinationId = Integer.parseInt(request.getParameter("destination"));
            f.setDeparture(ld.getById(departureId));
            f.setDestination(ld.getById(destinationId));
            f.setEntryTime(LocalDateTime.parse(request.getParameter("entryTime")));
            f.setStartingTime(LocalDateTime.parse(request.getParameter("startingTime")));
            f.setLandingTime(LocalDateTime.parse(request.getParameter("landingTime")));
            f.setPrice(Integer.parseInt(request.getParameter("price")));

            validateFlight(f);
            FlightDAO dao = new FlightDAO();
            dao.insert(f);
            
            // success message
            HttpSession session = request.getSession();
            session.setAttribute("successMessage", "Flight '" + f.getName() + "' added successfully!");
            session.setMaxInactiveInterval(10);
            
            response.sendRedirect("list-flight");
        } catch (Exception e) {
            request.setAttribute("error", "Error adding flight: " + e.getMessage());
            doGet(request, response);
        }
    }

    private String generateFlightId() throws Exception {
        FlightDAO dao = new FlightDAO();
        String highestId = dao.getHighestFlightId();
        if (highestId == null) {
            return "FL001";
        } else {
            String numericPart = highestId.substring(2); // Remove "FL"
            int nextNumber = Integer.parseInt(numericPart) + 1;
            // Format with leading zeros (e.g., FL001, FL002, etc.)
            return String.format("FL%03d", nextNumber);
        }
    }

    private String generateFlightCode() throws Exception {
        FlightDAO dao = new FlightDAO();
        String highestCode = dao.getHighestFlightCode();
        if (highestCode == null) {
            return "VN001";
        } else {
            String numericPart = highestCode.substring(2); // Remove "VN"
            int nextNumber = Integer.parseInt(numericPart) + 1;
            // Format with leading zeros (e.g., VN001, VN002, etc.)
            return String.format("VN%03d", nextNumber);
        }
    }

    private void validateFlight(Flight f) throws Exception {
        FlightDAO dao = new FlightDAO();
        if (dao.getFlightByName(f.getName()) != null) {
            throw new Exception("Flight name already exists.");
        }
        if (f.getName() == null || f.getName().trim().isEmpty()) {
            throw new Exception("Flight name is required");
        }
        if(f.getPrice() < 100000){
            throw new Exception("Price cannot smaller than 100.000");
        }
        if (f.getDeparture().getId() == f.getDestination().getId()) {
            throw new Exception("Departure and destination cannot be the same location");
        }
        if (f.getStartingTime().isBefore(f.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (f.getLandingTime().isBefore(f.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
        if(f.getLandingTime().equals(f.getStartingTime())){
            throw new Exception("Landing time must not be equal to starting time");
        }
    }
}
