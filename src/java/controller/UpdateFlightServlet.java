/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.FlightDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
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
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String code = request.getParameter("code");
            String airplaneId = request.getParameter("airplaneId");
            String departure = request.getParameter("departure");
            String destination = request.getParameter("destination");

            Flight f = new Flight();
            f.setId(id);
            f.setName(name);
            f.setCode(code);
            f.setAirplaneId(airplaneId);
            f.setDeparture(departure);
            f.setDestination(destination);

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
                String id = request.getParameter("id");
                FlightDAO dao = new FlightDAO();
                Flight f = dao.getFlightById(id);
                request.setAttribute("flight", f);
            } catch (Exception e) {
                // If we can't get the flight, we'll just show the error
            }

            request.setAttribute("error", "Failed to update flight: " + ex.getMessage());
            request.getRequestDispatcher("flight-update.jsp").forward(request, response);
        }
    }

    private void validateFlight(Flight f) throws Exception {
        if (f.getStartingTime().isBefore(f.getEntryTime())) {
            throw new Exception("Starting time must be after entry time");
        }
        if (f.getLandingTime().isBefore(f.getStartingTime())) {
            throw new Exception("Landing time must be after starting time");
        }
    }
}
