package controller;
import dal.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.*;
/**
 *
 * @author lytu
 */
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String requestedUrl = (String) request.getSession().getAttribute("requestedUrl");
//        request.setAttribute("requestedUrl", requestedUrl);
        request.getRequestDispatcher("/view/Login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean rememberMe = "true".equals(request.getParameter("rememberMe"));
        AccountDAO ad = new AccountDAO();
        Account acc = ad.login(username, password);

        if (acc == null || !acc.getUsername().equals(username) || !acc.getPassword().equals(password)) {
            request.setAttribute("error", "Invalid username or password!");
            request.getRequestDispatcher("/view/Login.jsp").forward(request, response);
            return;
        } 
        if (!acc.isStatus()) {
            request.setAttribute("error", "The account is not allowed to login to the system !!!");
            request.getRequestDispatcher("/view/Login.jsp").forward(request, response);
            return;
        }
        HttpSession session = request.getSession(true);
        session.setAttribute("acc", acc);
        session.setAttribute("user", username);
        session.setMaxInactiveInterval(3600);
        
        if (rememberMe) {
            Cookie userCookie = new Cookie("username", username);
            userCookie.setMaxAge(7 * 24 * 60 * 60);
            userCookie.setPath("/"); 
            response.addCookie(userCookie);
        }
//        String requestedUrl = (String) session.getAttribute("requestedUrl");
//        session.removeAttribute("requestedUrl");

        switch (acc.getRole().getId()) {
            case 1: //admin -> ve trang quan ly account
                response.sendRedirect(request.getContextPath()  + "/admin-sidebar.jsp");
                break;
            case 3: //staff 
                response.sendRedirect(request.getContextPath() + "/staff-sidebar.jsp");
                break;
            case 4: // atc -> manage flight
                
                response.sendRedirect(request.getContextPath() + "/atc-sidebar.jsp");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/home");
//                throw new AssertionError();
        }
    }
}
