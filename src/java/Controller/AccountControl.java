/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import model.Account;

/**
 *
 * @author anhbu
 */
public class AccountControl extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        AccountDAO dao = new AccountDAO();

        List<Account> listA = dao.getAllAccounts();
        String sortOrder = request.getParameter("sortOrder");// Lấy tham số sắp xếp từ URL
        String roleFilter = request.getParameter("role"); // Lấy giá trị role từ request
        String pageStr = request.getParameter("page");

        // Sắp xếp danh sách theo RoleID
        if ("asc".equals(sortOrder)) {
            listA.sort(Comparator.comparingInt(Account::getRoleID)); // Tăng dần
        } else if ("desc".equals(sortOrder)) {
            listA.sort(Comparator.comparingInt(Account::getRoleID).reversed()); // Giảm dần
        }

        //Lọc tài khoản theo roleID
        if (roleFilter != null && !roleFilter.isEmpty()) {
            int roleID = -1;
            switch (roleFilter) {
                case "Staff" ->
                    roleID = 2;
                case "Customer" ->
                    roleID = 3;
                case "AirTrafficControl" ->
                    roleID = 4;
            }
            if (listA != null) {
                Iterator<Account> iterator = listA.iterator();
                while (iterator.hasNext()) {
                    if (iterator.next().getRoleID() != roleID) {
                        iterator.remove();
                    }
                }
            }

        }

        // Phân trang
        int recordsPerPage = 5; // Số tài khoản mỗi trang
        int totalAccounts = listA.size();
        int totalPages = (int) Math.ceil((double) totalAccounts / recordsPerPage);

        int page = 1; // Mặc định trang đầu tiên
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
                if (page > totalPages) {
                    page = totalPages;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalAccounts);
        List<Account> paginatedList = listA.subList(startIndex, endIndex);
        request.setAttribute("listA", paginatedList);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("view/Manageraccount.jsp").forward(request, response);
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
        processRequest(request, response);
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
