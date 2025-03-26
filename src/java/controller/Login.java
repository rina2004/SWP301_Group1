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
        session.setMaxInactiveInterval(60 * 30);
        if (rememberMe) {
            Cookie userCookie = new Cookie("username", username);
            userCookie.setMaxAge(7 * 24 * 60 * 60);
            userCookie.setPath("/"); 
            response.addCookie(userCookie);
        }
        if(acc.getRole().getId() == 2) response.sendRedirect(request.getContextPath() + "/view/order");
        else response.sendRedirect("view/Home.jsp");
    }
}
