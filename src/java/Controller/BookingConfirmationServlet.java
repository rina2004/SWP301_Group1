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
import jakarta.servlet.http.HttpSession;
import java.util.UUID;
import model.Flight;

/**
 *
 * @author A A
 */
public class BookingConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Récupérer l'ID du vol, la classe du billet et le nombre de passagers
            String flightId = request.getParameter("flightId");
            String ticketClass = request.getParameter("ticketClass");
            String passengers = request.getParameter("passengers");
            
            // Générer un ID de commande unique
            String orderId = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            // Récupérer les informations du vol depuis la base de données
            FlightDAO flightDAO = new FlightDAO();
            Flight flight = flightDAO.getFlightById(flightId);
            
            // Stocker les informations dans la session
            HttpSession session = request.getSession();
            session.setAttribute("orderId", orderId);
            session.setAttribute("flight", flight);
            session.setAttribute("ticketClass", ticketClass);
            session.setAttribute("passengers", passengers);
            
            // Rediriger vers la page de confirmation
            response.sendRedirect("booking-confirmation.jsp");
            
        } catch (Exception ex) {
            // En cas d'erreur, rediriger vers la page d'accueil avec un message d'erreur
            HttpSession session = request.getSession();
            session.setAttribute("errorMessage", "Une erreur s'est produite lors de la réservation. Veuillez réessayer.");
            response.sendRedirect("search-flights");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
