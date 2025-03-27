package controller;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
/**
 *
 * @author lytu
 */
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            session.removeAttribute("user");
            session.removeAttribute("acc");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/view/Login.jsp");
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }
}
