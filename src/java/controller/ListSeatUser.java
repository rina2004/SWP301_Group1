/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.AirplaneDAO;
import dal.SeatDAO;
import dal.TicketDAO;
import dal.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.ArrayList;
import model.Seat;
import org.json.JSONObject;
import java.io.PrintWriter;
import org.json.JSONException;

/**
 *
 * @author tungn
 */
public class ListSeatUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
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
            out.println("<title>Servlet ListSeatUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListSeatUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SeatDAO dao = new SeatDAO();
        AirplaneDAO airDao = new AirplaneDAO();
        String id = request.getParameter("id");
        String typeID = airDao.getIdbyID(id);
        ArrayList<Seat> seat = dao.showAllSeatByTypeID(typeID);
        request.setAttribute("seat", seat);
        request.setAttribute("id", id);
        request.getRequestDispatcher("view/ListSeatUser.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Đọc toàn bộ JSON từ request body
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
        String requestBody = sb.toString();

        // Debug: In ra dữ liệu nhận được
        System.out.println("📥 Dữ liệu nhận được từ frontend: " + requestBody);
        
        try {
            // Chuyển JSON thành Object
            JSONObject json = new JSONObject(requestBody);
            String seatId = json.optString("seatId", null);
            String ticketId = json.optString("ticketId", null);

            // Debug: In ra giá trị nhận được
            System.out.println("🔍 Nhận request: ticketId=" + ticketId + ", seatId=" + seatId);
            
            if (seatId == null || seatId.trim().isEmpty() || ticketId == null || ticketId.trim().isEmpty()) {
                System.out.println("❌ Lỗi: ticketId hoặc seatId bị null/empty");
                JSONObject jsonResponse = new JSONObject();
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Dữ liệu đầu vào không hợp lệ!");
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse.toString());
                return;
            }
            TicketDAO daot = new TicketDAO();
            SeatDAO daos = new SeatDAO();
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Ghế đã được đặt thành công!");
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse.toString());
            System.out.println("✅ Đặt ghế thành công!");
            
            daot.updateTicketbySeatID(ticketId, seatId);
            daos.updateBookedSeat(seatId);
        } catch (IOException | JSONException e) {
            System.out.println("❌ Lỗi xử lý JSON: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Lỗi xử lý JSON");
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
