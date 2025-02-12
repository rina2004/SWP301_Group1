/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FlightDAO;
import dal.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class ListFlightServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FlightDAO dao = new FlightDAO();
        ArrayList<Flight> list = dao.getAllFlight();
        request.setAttribute("list", list);

//        String successMessage = (String) request.getSession().getAttribute("successMessage");
//        if (successMessage != null) {
//            request.setAttribute("successMessage", successMessage);
//            request.getSession().removeAttribute("successMessage"); // Xóa thông báo sau khi hiển thị
//        }

        list.sort(Comparator.comparing(Flight::getName));

        request.getRequestDispatcher("flight-list.jsp").forward(request, response);

//        //test filter
//        String tID = request.getParameter("tID");
//        
//        TicketDAO tDao = new TicketDAO();
//        try {
//            Ticket t = tDao.getTicketById(tID);
//            request.setAttribute("tPrice", t.getPrice());
//            request.setAttribute("tType", t.getType());
//        } catch (Exception ex) {
//            Logger.getLogger(ListFlightServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        //end here
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.getSession().setAttribute("successMessage", "Flight created successfully!");
//        response.sendRedirect("list-flight");
//
//    }
}
