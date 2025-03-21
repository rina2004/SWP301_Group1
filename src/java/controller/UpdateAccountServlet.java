/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author A A
 */
public class UpdateAccountServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        
        if (account == null) {
            // User is not logged in, redirect to login page
            response.sendRedirect("login");
            return;
        }
        
        // Get form data
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // Validate email
        if (email == null || email.isEmpty() || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("account-details.jsp").forward(request, response);
            return;
        }
        
        // Validate phone number (Vietnamese format)
        if (phone == null || phone.isEmpty() || !phone.matches("^(0|\\+84)(3|5|7|8|9)\\d{8}$")) {
            request.setAttribute("error", "Invalid phone number format");
            request.getRequestDispatcher("account-details.jsp").forward(request, response);
            return;
        }
        
        // Update account information
        AccountDAO accountDAO = new AccountDAO();
        boolean updated = accountDAO.updateAccountDetails(account.getId(), email, phone);
        
        if (updated) {
            // Update session data
            account.setEmail(email);
            account.setPhone(phone);
            session.setAttribute("account", account);
            
            // Set success message
            session.setAttribute("successMessage", "Account information updated successfully");
            
            // Redirect to success page
            response.sendRedirect("update-success.jsp");
        } else {
            request.setAttribute("error", "Failed to update account information");
            request.getRequestDispatcher("account-details.jsp").forward(request, response);
        }
    }
}
