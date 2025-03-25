/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirplaneDAO;
import dal.FlightDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;
import model.Airplane;
import model.Flight;

/**
 *
 * @author A A
 */
public class AddFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirplaneDAO airplaneDao = new AirplaneDAO();
        List<Airplane> list = airplaneDao.list();
        request.setAttribute("airplanes", list);
        request.getRequestDispatcher("flight-form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            Flight f = new Flight();
            f.setId(generateFlightId());
            f.setName(request.getParameter("name"));
//            f.setCode(request.getParameter("code"));
            f.setCode(generateFlightCode(request.getParameter("name")));

            f.setAirplaneId(request.getParameter("airplaneId"));
            f.setDeparture(request.getParameter("departure"));
            f.setDestination(request.getParameter("destination"));

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

    private String generateFlightId() {
        // Generate a unique flight ID (implement your logic)
        return "F" + System.currentTimeMillis() % 10000;
    }

    private String generateFlightCode(String flightName) {
        // Extract numeric part from flight name
        String numericPart = flightName.replaceAll("[^0-9]", "");

        // If no numeric part found, use a default number
        if (numericPart.isEmpty()) {
            numericPart = String.valueOf(System.currentTimeMillis() % 1000);
        }

        return "FL" + numericPart;
    }

    private void validateFlight(Flight flight) throws Exception {
        FlightDAO dao = new FlightDAO();

        if (dao.getFlightById(flight.getId()) != null) {
            throw new Exception("Flight ID already exists.");
        }

        if (dao.getFlightByName(flight.getName()) != null) {
            throw new Exception("Flight name already exists.");
        }

        if (dao.getFlightByCode(flight.getCode()) != null) {
            throw new Exception("Flight code already exists.");
        }

        if (flight.getName() == null || flight.getName().trim().isEmpty()) {
            throw new Exception("Flight name is required");
        }
        if (flight.getCode() == null || flight.getCode().trim().isEmpty()) {
            throw new Exception("Flight code is required");
        }
        if (flight.getStartingTime().isBefore(flight.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (flight.getLandingTime().isBefore(flight.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
    }
}
