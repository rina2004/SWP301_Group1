/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
        AccountDAO accountDAO = new AccountDAO();  // Tạo instance của DAO
        Account sessionAccount = (Account) session.getAttribute("acc");

        if (sessionAccount == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        // Lấy dữ liệu mới nhất từ database
        Account account = accountDAO.getUserByID(sessionAccount.getId());

        if (account == null) {
            response.sendRedirect("view/Login.jsp");
            return;
        }

        // Cập nhật session và chuyển đến JSP
        session.setAttribute("acc", account);
        request.setAttribute("account", account);
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

        // Kiểm tra nếu name không được để trống
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Full name is required!");
            response.sendRedirect("profile");
            return;
        }

        // Kiểm tra định dạng của name (chỉ chứa chữ cái và khoảng trắng, từ 2 đến 50 ký tự)
        if (!name.matches(namePattern)) {
            session.setAttribute("error", "Full name must contain only letters and spaces (2-50 characters).");
            response.sendRedirect("profile");
            return;
        }

        // Nếu có nhập email thì mới kiểm tra định dạng
        if (email != null && !email.trim().isEmpty() && !email.matches(emailPattern)) {
            session.setAttribute("error", "Invalid email format!");
            response.sendRedirect("profile");
            return;
        }

        // Nếu có nhập số điện thoại thì mới kiểm tra định dạng
        if (phone != null && !phone.trim().isEmpty() && !phone.matches(phonePattern)) {
            session.setAttribute("error", "Phone number must be 10-11 digits!");
            response.sendRedirect("profile");
            return;
        }

        // Nếu có nhập citizenID thì mới kiểm tra định dạng
        if (citizenID != null && !citizenID.trim().isEmpty() && !citizenID.matches(citizenIDPattern)) {
            session.setAttribute("error", "Citizen ID must be 9-12 digits!");
            response.sendRedirect("profile");
            return;
        }

        // Xử lý ngày sinh (cho phép để trống)
        Date dob = null;
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                sdf.setLenient(false);
                java.util.Date utilDate = sdf.parse(dobStr);

                // Kiểm tra nếu ngày sinh ở tương lai
                java.util.Date currentDate = new java.util.Date();
                if (utilDate.after(currentDate)) {
                    session.setAttribute("error", "Date of birth cannot be in the future!");
                    response.sendRedirect("profile");
                    return;
                }

                dob = new Date(utilDate.getTime()); // Chuyển thành java.sql.Date
            } catch (ParseException e) {
                session.setAttribute("error", "Invalid date format!");
                response.sendRedirect("profile");
                return;
            }
        }

        // Lấy tài khoản từ session
        Account acc = (Account) session.getAttribute("acc");

        if (acc != null) {
            // Cập nhật thông tin tài khoản (nếu người dùng để trống, giữ nguyên giá trị cũ)
            acc.setName(name);
            acc.setCitizenID((citizenID != null && !citizenID.trim().isEmpty()) ? citizenID : acc.getCitizenID());
            acc.setDob(dob != null ? dob : acc.getDob());
            acc.setPhone((phone != null && !phone.trim().isEmpty()) ? phone : acc.getPhone());
            acc.setAddress((address != null && !address.trim().isEmpty()) ? address : acc.getAddress());
            acc.setEmail((email != null && !email.trim().isEmpty()) ? email : acc.getEmail());

            // Gọi DAO để cập nhật database
            AccountDAO dao = new AccountDAO();
            dao.updateProfile(acc); // Đảm bảo phương thức này cập nhật theo userID

            // Lấy lại thông tin mới từ database
            Account updatedAcc = dao.getUserByID(acc.getId());
            session.setAttribute("acc", updatedAcc); // Cập nhật lại session với thông tin mới

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
