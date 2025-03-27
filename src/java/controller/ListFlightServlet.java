/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import model.*;

/**
 *
 * @author A A
 */
public class ListFlightServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FlightDAO dao = new FlightDAO();
        ArrayList<Flight> list;
        //if sort
        String order = request.getParameter("order");
        if (order == null) {
            list = dao.list();
        } else {
            list = switch (order) {
                case "asc" -> dao.ascendingPrice();
                case "desc" -> dao.descendingPrice();
                default -> dao.list();
            };
        }
        request.setAttribute("list", list);
        request.getRequestDispatcher("flight-list.jsp").forward(request, response);
    }
}
