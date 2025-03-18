/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.CompartmentDAO;
import dal.TypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Type;

/**
 *
 * @author tungn
 */
public class CreateCompartment extends HttpServlet {

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
            out.println("<title>Servlet CreateCompartment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateCompartment at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("id");  // Lấy id từ URL
        TypeDAO dao = new TypeDAO();
        String id1 = dao.getTypeIDbyID(id); // Lấy Type ID dựa vào ID đã chọn

        request.setAttribute("typeID", id1);
        request.getRequestDispatcher("view/CreateCompartment.jsp").forward(request, response);
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
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String typeid = request.getParameter("typeid");
        String capacity = request.getParameter("capacity");

        if (id == null || id.length() != 1) {
            request.setAttribute("error", "ID must be a single character!");
            request.getRequestDispatcher("view/CreateCompartment.jsp").forward(request, response);
            return;
        }

        char charId = id.charAt(0);
        CompartmentDAO dao = new CompartmentDAO();

        try {
            int capacity1 = Integer.parseInt(capacity);

            // Kiểm tra khoang có tồn tại không
            if (dao.isCompartmentExist(charId, typeid)) {
                request.setAttribute("typeID", typeid);
                request.setAttribute("existed", "Compartment with this ID and Type already exists!");
                request.getRequestDispatcher("view/CreateCompartment.jsp").forward(request, response);
                return;
            }

            // Lấy đối tượng Type
            TypeDAO dao2 = new TypeDAO();
            Type t = dao2.getTypeByID(typeid);

            if (t == null) {
                request.setAttribute("typeID", typeid);
                request.setAttribute("error", "Invalid Type ID!");
                request.getRequestDispatcher("view/CreateCompartment.jsp").forward(request, response);
                return;
            }

            // Tạo khoang mới
            dao.createNewCompartment(charId, name, t, capacity1);
            response.sendRedirect(request.getContextPath() + "/list");

        } catch (NumberFormatException e) {
            request.setAttribute("typeID", typeid);
            request.setAttribute("errnumber", "Capacity must be a valid number!");
            request.getRequestDispatcher("view/CreateCompartment.jsp").forward(request, response);
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
