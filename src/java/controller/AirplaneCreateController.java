/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AirplaneDAO;
import dal.AirplaneStatusDBContext;
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

/**
 *
 * @author Rinaaaa
 */
public class AirplaneCreateController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AirplaneCreateController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AirplaneCreateController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
        List<AirplaneStatus> statuses = statusDB.list();
        request.setAttribute("statuses", statuses);
        
        request.getRequestDispatcher("/view/createAirplane.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirplaneDAO airplaneDAO = new AirplaneDAO();
        
        try {
            // Nhận thông tin máy bay
            String id = request.getParameter("airId");
            String name = request.getParameter("airName");
            int statusID = Integer.parseInt(request.getParameter("airStatusID"));
            int numOfComs = Integer.parseInt(request.getParameter("numOfComs"));
            LocalDateTime maintainanceTime = LocalDateTime.parse(request.getParameter("maintainanceTime"));
            LocalDateTime usedTime = LocalDateTime.parse(request.getParameter("usedTime"));

            Airplane airplane = new Airplane();
            airplane.setId(id);
            airplane.setName(name);
            
            AirplaneStatus status = new AirplaneStatus();
            status.setId(statusID); 
            airplane.setStatus(status);
            
            airplane.setMaintainanceTime(maintainanceTime);
            airplane.setUsedTime(usedTime);
            airplane.setNumOfComs(numOfComs);
            airplane.setCompartments(new ArrayList<>());

            for (int i = 0; i < numOfComs; i++) {
                String compName = request.getParameter("compartment"+i+".name");
                int capacity = Integer.parseInt(request.getParameter("compartment"+i+".capacity"));
                
                String compId = airplane.getId() + "-" + compName.charAt(0);

                Compartment compartment = new Compartment();
                compartment.setId(compId);
                compartment.setName(compName);
                compartment.setCapacity(capacity);

                // Danh sách seats trong compartment
                ArrayList<Seat> seats = new ArrayList<>();
                for (int j = 1; j <= compartment.getCapacity(); j++) {
                    String seatId = compId + "-" + String.format("%02d", j);
                    String seatStatus = "Available";

                    Seat seat = new Seat();
                    seat.setId(seatId);
                    seat.setStatus(seatStatus);
                    seats.add(seat);
                }
                compartment.setSeats(seats);
                airplane.getCompartments().add(compartment);
            }

            airplaneDAO.insert(airplane);

            response.sendRedirect(request.getContextPath() + "/airplane/view");
        } catch (IOException | NumberFormatException e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
