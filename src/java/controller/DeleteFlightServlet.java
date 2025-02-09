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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author A A
 */
public class DeleteFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            request.getSession().setAttribute("errorMessage", "Invalid flight ID");
            response.sendRedirect("list-flight");
            return;
        }
        
        FlightDAO dao = new FlightDAO();
        try {
            boolean deleted = dao.deleteFlight(id);
            if (deleted) {
                request.getSession().setAttribute("successMessage", "Flight deleted successfully");
            }
        } catch (Exception ex) {
            Logger.getLogger(DeleteFlightServlet.class.getName()).log(Level.SEVERE, "Error deleting flight", ex);
        }
        response.sendRedirect("list-flight");
    }
}