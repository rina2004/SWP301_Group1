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
import java.util.List;
import model.Flight;

/**
 *
 * @author A A
 */
public class FilterFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String priceRange = request.getParameter("priceRange");
        FlightDAO flightDao = new FlightDAO();
        List<Flight> flights;
        
        switch(priceRange) {
            case "cheapest":
                flights = flightDao.getFlightsByPriceRange(0, 200);
                break;
            case "best":
                flights = flightDao.getFlightsByPriceRange(200, 1000000);
                break;
            case "quickest":
                flights = flightDao.getFlightsByPriceRange(1000000, Double.MAX_VALUE);
                break;
            default:
                flights = flightDao.getAllFlight();
        }
        
        request.setAttribute("list", flights);
        request.getRequestDispatcher("list-flight").forward(request, response);
    }
}