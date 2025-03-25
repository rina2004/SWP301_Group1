/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.FlightDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;

/**
 *
 * @author A A
 */
public class OrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String departure = request.getParameter("departure");
        String destination = request.getParameter("destination");
        String departureDate = request.getParameter("departureDate");

        // Save search parameters for the back button
        request.setAttribute("departure", departure);
        request.setAttribute("destination", destination);
        request.setAttribute("departureDate", departureDate);

        FlightDAO dao = new FlightDAO();
        Flight f;
        try {
            f = dao.getFlightById(id);
            if (f != null) {
                request.setAttribute("flight", f);
                request.getRequestDispatcher("order-result-detail.jsp").forward(request, response);
            }
        } catch (Exception ex) {
//            Logger.getLogger(ViewFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
