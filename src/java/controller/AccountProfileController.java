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
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import model.Account;

/**
 *
 * @author anhbu
 */
public class AccountProfileController extends HttpServlet {

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
            out.println("<title>Servlet ProfileAccountControl</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileAccountControl at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        HttpSession session = request.getSession();
        AccountDAO accountDAO = new AccountDAO();
        Account sessionAccount = (Account) session.getAttribute("acc");

        // Kiểm tra nếu chưa đăng nhập
        if (sessionAccount == null || sessionAccount.getUsername() == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        // Lấy tài khoản theo username
        Account account = accountDAO.getAccountByUsername(sessionAccount.getUsername());

        // Kiểm tra nếu tài khoản đã bị xóa khỏi database
        if (account == null) {
            session.removeAttribute("acc"); // Xóa session
            response.sendRedirect("view/Login.jsp");
            return;
        }

        // Cập nhật session và request attribute
        session.setAttribute("acc", account);
        request.setAttribute("profileAccount", account);
        request.getRequestDispatcher("view/Profileaccount.jsp").forward(request, response);
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
        //processRequest(request, response);
        HttpSession session = request.getSession();

        // Lấy dữ liệu từ form
        String name = request.getParameter("name");
        String citizenID = request.getParameter("citizenID");
        String dobStr = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String email = request.getParameter("email");

        // Kiểm tra dữ liệu hợp lệ
        String namePattern = "^[A-Za-zÀ-ỹ\\s]{2,50}$";
        String emailPattern = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        String phonePattern = "^[0-9]{10}$";
        String citizenIDPattern = "^[0-9]{9,12}$";

        if (name == null || name.trim().isEmpty() || !name.matches(namePattern)) {
            session.setAttribute("error", "Invalid full name!");
            response.sendRedirect("profile");
            return;
        }

        if (email != null && !email.trim().isEmpty() && !email.matches(emailPattern)) {
            session.setAttribute("error", "Invalid email format!");
            response.sendRedirect("profile");
            return;
        }

        if (phone != null && !phone.trim().isEmpty() && !phone.matches(phonePattern)) {
            session.setAttribute("error", "Phone number must be 10 digits!");
            response.sendRedirect("profile");
            return;
        }

        if (citizenID != null && !citizenID.trim().isEmpty() && !citizenID.matches(citizenIDPattern)) {
            session.setAttribute("error", "Citizen ID must be 9-12 digits!");
            response.sendRedirect("profile");
            return;
        }

        // Xử lý ngày sinh
        Date dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                sdf.setLenient(false);
                java.util.Date utilDate = sdf.parse(dobStr);
                if (utilDate.after(new java.util.Date())) {
                    session.setAttribute("error", "Date of birth cannot be in the future!");
                    response.sendRedirect("profile");
                    return;
                }
                dob = new Date(utilDate.getTime());
            } catch (ParseException e) {
                session.setAttribute("error", "Invalid date format!");
                response.sendRedirect("profile");
                return;
            }
        }

        // Lấy tài khoản từ session
        Account acc = (Account) session.getAttribute("acc");

        if (acc != null) {
            acc.setName(name);
            acc.setCitizenID((citizenID != null && !citizenID.trim().isEmpty()) ? citizenID : acc.getCitizenID());
            acc.setDob(dob != null ? dob : acc.getDob());
            acc.setPhone((phone != null && !phone.trim().isEmpty()) ? phone : acc.getPhone());
            acc.setAddress((address != null && !address.trim().isEmpty()) ? address : acc.getAddress());
            acc.setEmail((email != null && !email.trim().isEmpty()) ? email : acc.getEmail());

            // Cập nhật vào database
            AccountDAO dao = new AccountDAO();
            dao.updateProfile(acc);

            // Lấy lại thông tin theo username để cập nhật session
            Account updatedAcc = dao.getAccountByUsername(acc.getUsername());
            session.setAttribute("acc", updatedAcc);

            session.setAttribute("success", "Profile updated successfully!");
            response.sendRedirect("profile");
        } else {
            session.setAttribute("error", "Unauthorized update attempt!");
            response.sendRedirect("profile");
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
