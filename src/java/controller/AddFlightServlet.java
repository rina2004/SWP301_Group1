/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.FlightDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import model.Flight;

/**
 *
 * @author A A
 */
public class AddFlightServlet extends HttpServlet {
    
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//            // Load airplane --> dropdown
//        AirplaneDAO airplaneDao = new AirplaneDAO();
//        List<Airplane> list = airplaneDao.getAllAirplanes();
//        request.setAttribute("airplanes", list);
//        request.getRequestDispatcher("flight-form.jsp").forward(request, response);
//    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Set character encoding
            request.setCharacterEncoding("UTF-8");
            
            Flight f = new Flight();
            // Set basic properties
            f.setId(generateFlightId()); // Method to generate unique ID
            f.setName(request.getParameter("name"));
            f.setCode(request.getParameter("code"));
            f.setAirplaneId(request.getParameter("airplaneId"));
            f.setDeparture(request.getParameter("departure"));
            f.setDestination(request.getParameter("destination"));
          
            // Parse and set timestamps
            try {
                f.setEntryTime(Date.valueOf(request.getParameter("entryTime").replace("T", " ") + ":00"));
                f.setStartingTime(Date.valueOf(request.getParameter("startingTime").replace("T", " ") + ":00"));
                f.setLandingTime(Date.valueOf(request.getParameter("landingTime").replace("T", " ") + ":00"));
            } catch (IllegalArgumentException e) {
                throw new Exception("Invalid date format");
            }
            
            // Validate flight data
            validateFlight(f);
            
            FlightDAO dao = new FlightDAO();
            dao.insertFlight(f);
            
            response.sendRedirect("list-flight?message=Flight added successfully&alert=success");
        } catch (Exception e) {
            request.setAttribute("error", "Error adding flight: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private String generateFlightId() {
        // Generate a unique flight ID (implement your logic)
        return "F" + System.currentTimeMillis() % 10000;
    }
    
    private void validateFlight(Flight flight) throws Exception {
        if (flight.getName() == null || flight.getName().trim().isEmpty()) {
            throw new Exception("Flight name is required");
        }
        if (flight.getCode() == null || flight.getCode().trim().isEmpty()) {
            throw new Exception("Flight code is required");
        }
        if (flight.getStartingTime().before(flight.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (flight.getLandingTime().before(flight.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
    }
}

