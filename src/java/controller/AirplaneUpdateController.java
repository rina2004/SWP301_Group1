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
import java.util.List;
import model.Airplane;
import model.AirplaneStatus;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneUpdateController extends HttpServlet {
   
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
            out.println("<title>Servlet AirplaneUpdateController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AirplaneUpdateController at " + request.getContextPath () + "</h1>");
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
        String id = request.getParameter("id");
        
        AirplaneDAO airplaneDB = new AirplaneDAO();
        Airplane airplane = airplaneDB.get(id);
        
        if (airplane == null) {
            response.sendRedirect(request.getContextPath() + "/airplane/view");
            return;
        }
        
        AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
        List<AirplaneStatus> statuses = statusDB.list();
        
        request.setAttribute("airplane", airplane);
        request.setAttribute("statuses", statuses);
        
        request.getRequestDispatcher("/view/updateAirplane.jsp").forward(request, response);
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
            String id = request.getParameter("id");
            AirplaneDAO airplaneDB = new AirplaneDAO();
            Airplane airplane = airplaneDB.get(id);
            
            if (airplane == null) {
                response.sendRedirect(request.getContextPath() + "/airplane/view");
                return;
            }
            
            // Update status
            int statusId = Integer.parseInt(request.getParameter("status"));
            AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
            AirplaneStatus status = statusDB.get(statusId);
            airplane.setStatus(status);
            
            // Update maintenance time
            String maintainanceTime = request.getParameter("maintainanceTime");
            airplane.setMaintainanceTime(LocalDateTime.parse(maintainanceTime));
            
            // Perform update
            airplaneDB.update(airplane);
            
            response.sendRedirect(request.getContextPath() + "/airplane/view?message=Update successful");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error updating airplane: " + e.getMessage());
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
