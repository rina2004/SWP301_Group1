/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AirTrafficControlDBContext;
import dal.AirplaneDAO;
import dal.AirplaneStatusDBContext;
import dal.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import model.AirTrafficControl;
import model.Airplane;
import model.AirplaneStatus;
import model.Type;

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
        try {
            request.setCharacterEncoding("UTF-8");

            Airplane a = new Airplane();
            a.setName(request.getParameter("name"));

            // Handle type
            String typeId = request.getParameter("type");
            TypeDAO typeDB = new TypeDAO();
            a.setType(typeDB.get(typeId));

            // Handle status
            String statusId = request.getParameter("status");
            AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
            a.setStatus(statusDB.get(Integer.parseInt(statusId)));

            // Handle dates
            String maintainanceTime = request.getParameter("maintainanceTime");
            a.setMaintainanceTime(LocalDateTime.parse(maintainanceTime));

            String usedTime = request.getParameter("usedTime");
            a.setUsedTime(LocalDateTime.parse(usedTime));

            // Handle ATC
            String actID = request.getParameter("actID");
            AirTrafficControlDBContext atcDB = new AirTrafficControlDBContext();
            AirTrafficControl atc = atcDB.get(actID);
            if (atc == null) {
                throw new IllegalArgumentException("Invalid Air Traffic Control ID: " + actID);
            }
            a.setAtc(atc);

            // Insert airplane
            AirplaneDAO dao = new AirplaneDAO();
            dao.insert(a);
            
            response.sendRedirect(request.getContextPath() + "/airplane/view");
        } catch (IOException | IllegalArgumentException e) {
            request.setAttribute("error", "Error adding airplane: " + e.getMessage());
            doGet(request, response);
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
