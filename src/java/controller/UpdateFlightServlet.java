/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.FlightDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;

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
        Flight f;
        try {
            f = dao.getFlightById(id);
            request.setAttribute("flight", f);
            request.getRequestDispatcher("flight-update.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(UpdateFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Get parameters from the form
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String airplaneId = request.getParameter("airplaneId");
            String departure = request.getParameter("departure");
            String destination = request.getParameter("destination");

            // Convert datetime-local string to Date format YYYY-MM-DD
            String entryTimeStr = request.getParameter("entryTime").split("T")[0];
            String startingTimeStr = request.getParameter("startingTime").split("T")[0];
            String landingTimeStr = request.getParameter("landingTime").split("T")[0];

            Date entryTime = Date.valueOf(entryTimeStr);
            Date startingTime = Date.valueOf(startingTimeStr);
            Date landingTime = Date.valueOf(landingTimeStr);

            Flight f = new Flight();
            f.setId(id);
            f.setName(name);
            f.setCode(code);
            f.setAirplaneId(airplaneId);
            f.setDeparture(departure);
            f.setDestination(destination);
            f.setEntryTime(entryTime);
            f.setStartingTime(startingTime);
            f.setLandingTime(landingTime);

            FlightDAO dao = new FlightDAO();
            dao.updateFlight(f);

            response.sendRedirect("list-flight");
        } catch (Exception ex) {
            Logger.getLogger(UpdateFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Failed to update flight: " + ex.getMessage());
            request.getRequestDispatcher("flight-update.jsp").forward(request, response);
        }
    }
}