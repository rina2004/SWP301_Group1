/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

<<<<<<<< HEAD:src/java/controller/OrderDetailControl.java
import dal.TicketDAO;
========
import dal.CompartmentDAO;
>>>>>>>> rina2004:src/java/controller/UpdateCompartment.java
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<<< HEAD:src/java/controller/OrderDetailControl.java
import java.util.List;
import model.Ticket;

/**
 *
 * @author anhbu
 */
public class OrderDetailControl extends HttpServlet {
========
import model.Compartment;

/**
 *
 * @author tungn
 */
public class UpdateCompartment extends HttpServlet {
>>>>>>>> rina2004:src/java/controller/UpdateCompartment.java

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
<<<<<<<< HEAD:src/java/controller/OrderDetailControl.java
            out.println("<title>Servlet OrderDetailControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailControl at " + request.getContextPath() + "</h1>");
========
            out.println("<title>Servlet UpdateCompartment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCompartment at " + request.getContextPath() + "</h1>");
>>>>>>>> rina2004:src/java/controller/UpdateCompartment.java
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
<<<<<<<< HEAD:src/java/controller/OrderDetailControl.java
        //processRequest(request, response);
        // Lấy orderId từ request param
        String orderId = request.getParameter("orderId");

        // Tương tác trực tiếp DAO
        TicketDAO ticketDAO = new TicketDAO();
        List<Ticket> tickets = ticketDAO.getTicketsByOrderId(orderId);


        // Đổ data ra view
        request.setAttribute("tickets", tickets);
        request.getRequestDispatcher("view/OrderDetail.jsp").forward(request, response);
========
        CompartmentDAO dao = new CompartmentDAO();
        String id = request.getParameter("id");
        String type = request.getParameter("type");
        
       
        request.getRequestDispatcher("view/UpdateCompartment.jsp").forward(request, response);
>>>>>>>> rina2004:src/java/controller/UpdateCompartment.java
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
<<<<<<<< HEAD:src/java/controller/OrderDetailControl.java
        //processRequest(request, response);
        
========
        String id = request.getParameter("id");
        String type = request.getParameter("typeid");
        String cap = request.getParameter("capacity");

        try {
            int newCapacity = Integer.parseInt(cap);
            CompartmentDAO dao = new CompartmentDAO();
          
            response.sendRedirect(request.getContextPath() + "/list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid capacity value!");
            request.getRequestDispatcher("view/updateCompartment.jsp").forward(request, response);
        }
>>>>>>>> rina2004:src/java/controller/UpdateCompartment.java
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
