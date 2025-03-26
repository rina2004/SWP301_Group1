/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AirplaneDAO;
import dal.AirplaneStatusDBContext;
import dal.TicketTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.Airplane;
import model.AirplaneStatus;
import model.Compartment;
import model.Seat;
import model.TicketType;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneUpdateDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
        List<AirplaneStatus> statuses = statusDB.list();
        TicketTypeDAO ticketDB = new TicketTypeDAO();
        List<TicketType> ticketTypes = ticketDB.list();

        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/airplane/view");
            return;
        }

        AirplaneDAO airplaneDAO = new AirplaneDAO();
        Airplane airplane = airplaneDAO.getDetail(id);

        if (airplane == null) {
            response.sendRedirect(request.getContextPath() + "/airplane/view");
            return;
        }

        request.setAttribute("airplane", airplane);
        request.setAttribute("statuses", statuses);
        request.setAttribute("compartmentTypes", ticketTypes);
        request.getRequestDispatcher("/view/updateAirplane.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AirplaneDAO airplaneDAO = new AirplaneDAO();

        try {
            String id = request.getParameter("id");
            int statusID = Integer.parseInt(request.getParameter("statusID"));
            int numOfComs = Integer.parseInt(request.getParameter("numOfComs"));
            LocalDateTime maintainanceTime = LocalDateTime.parse(request.getParameter("maintainanceTime"));
            LocalDateTime usedTime = LocalDateTime.parse(request.getParameter("usedTime"));

            Airplane existingAirplane = airplaneDAO.get(id);
            if (existingAirplane == null) {
                response.sendRedirect(request.getContextPath() + "/airplane/view");
            }

            if (numOfComs < existingAirplane.getNumOfComs()) {
                request.setAttribute("error", "Number of compartments cannot be decreased.");
                request.setAttribute("airplane", existingAirplane);
                request.getRequestDispatcher("/view/updateAirplane.jsp").forward(request, response);
                return;
            }

            Airplane airplane = new Airplane();
            airplane.setId(id);
            AirplaneStatus as = new AirplaneStatus();
            as.setId(statusID);
            airplane.setStatus(as);
            airplane.setNumOfComs(numOfComs);
            airplane.setMaintainanceTime(maintainanceTime);
            airplane.setUsedTime(usedTime);

            ArrayList<Compartment> compartments = new ArrayList<>();
            for (int i = 0; i < numOfComs; i++) {
                String compId = request.getParameter("compartmentId" + i);
                int capacity = Integer.parseInt(request.getParameter("capacity" + i));
                
                Compartment existingComp = existingAirplane.getCompartmentById(compId);
                if (existingComp != null && capacity < existingComp.getCapacity()) {
                    request.setAttribute("error", "Compartment " + compId + " capacity cannot be decreased.");
                    request.setAttribute("airplane", existingAirplane);
                    request.getRequestDispatcher("/view/updateAirplane.jsp").forward(request, response);
                }

                Compartment compartment = new Compartment();
                compartment.setId(compId);
                compartment.setCapacity(capacity);

                ArrayList<Seat> seats = new ArrayList<>();
                for (int j = 1; j <= capacity; j++) {
                    String seatId = request.getParameter("seatId" + i + "_" + j);
                    String seatStatus = request.getParameter("seatStatus" + i + "_" + j);

                    Seat seat = new Seat();
                    seat.setId(seatId);
                    seat.setStatus(seatStatus);
                    seats.add(seat);
                }
                compartment.setSeats(seats);
                compartments.add(compartment);
            }

            airplane.setCompartments(compartments);
            airplaneDAO.update(airplane);

            response.sendRedirect(request.getContextPath() + "/airplane/view/detail?id=" + id + "&success=true");
        } catch (ServletException | IOException | NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/airplane/view/detail?id=" + request.getParameter("id") + "&error=true");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
