/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import dal.AirTrafficControlDBContext;
import dal.AirplaneDAO;
import dal.AirplaneStatusDBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.List;
import model.AirTrafficControl;
import model.Airplane;
import model.AirplaneStatus;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneCreateController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirTrafficControlDBContext atcDB = new AirTrafficControlDBContext();
        List<AirTrafficControl> atcs = atcDB.list();
        request.setAttribute("atcs", atcs);

        AirplaneStatusDBContext statusDB = new AirplaneStatusDBContext();
        List<AirplaneStatus> statuses = statusDB.list();
        request.setAttribute("statuses", statuses);
        
        request.getRequestDispatcher("/view/createAirplane.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            Airplane a = new Airplane();
            a.setName(request.getParameter("name"));

            // Handle type
            String typeId = request.getParameter("type");

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
//            String actID = request.getParameter("actID");
//            AirTrafficControlDBContext atcDB = new AirTrafficControlDBContext();
//            AirTrafficControl atc = atcDB.get(actID);
//            if (atc == null) {
//                throw new IllegalArgumentException("Invalid Air Traffic Control ID: " + actID);
//            }
//            a.setAtc(atc);

            AirplaneDAO dao = new AirplaneDAO();
            dao.insert(a);
            
            response.sendRedirect(request.getContextPath() + "/airplane/view");
        } catch (IOException | IllegalArgumentException e) {
            request.setAttribute("error", "Error adding airplane: " + e.getMessage());
            doGet(request, response);
        }
    }

}
