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
            
            int statusId = Integer.parseInt(request.getParameter("status"));
            AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
            AirplaneStatus status = statusDB.get(statusId);
            airplane.setStatus(status);
            
            String maintainanceTime = request.getParameter("maintainanceTime");
            airplane.setMaintainanceTime(LocalDateTime.parse(maintainanceTime));
            
            airplaneDB.update(airplane);
            
            response.sendRedirect(request.getContextPath() + "/airplane/view?message=Update successful");
            
        } catch (Exception e) {
            request.setAttribute("error", "Error updating airplane: " + e.getMessage());
            doGet(request, response);
        }
    }
}
