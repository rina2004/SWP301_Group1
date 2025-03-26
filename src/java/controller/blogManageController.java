/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Blog;
import model.PageControl;
import dal.BlogDAO;
import dal.PostDAO;

/**
 *
 * @author DUCDA
 */
public class blogManageController extends HttpServlet {

    BlogDAO blogDAO = new BlogDAO();
    PostDAO postDAO = new PostDAO();

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
            out.println("<title>Servlet blogManageController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet blogManageController at " + request.getContextPath() + "</h1>");
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
        String searchQuery = request.getParameter("search");
        List<Blog> listBlog;
        PageControl pageControl = new PageControl();

        String requestURL = request.getRequestURL().toString();

        String pageRaw = request.getParameter("page");
        int page;
        try {
            page = Integer.parseInt(pageRaw);
            if (page <= 0) {
                page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        int totalRecord;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            listBlog = blogDAO.searchBlogs(searchQuery, page); // Gọi DAO để tìm kiếm
            pageControl.setUrlPattern(requestURL + "?search=" + searchQuery + "&");
            totalRecord = blogDAO.findTotalRecordByKeyWord(searchQuery);
        } else {
            listBlog = blogDAO.getAllBlogs(page); // Lấy toàn bộ danh sách blog nếu không tìm kiếm
            pageControl.setUrlPattern(requestURL + "?");
            totalRecord = blogDAO.findAllTotalRecord();
        }

        int record_per_page = 4;
        int totalPage;
        if (totalRecord % record_per_page == 0) {
            totalPage = totalRecord / record_per_page;
        } else {
            totalPage = (totalRecord / record_per_page) + 1;
        }
        pageControl.setPage(page);
        pageControl.setTotalPage(totalPage);
        pageControl.setTotalRecord(totalRecord);

        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("listBlog", listBlog);
        request.setAttribute("pageControl", pageControl);
        request.getRequestDispatcher("blog-manage.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            String title = request.getParameter("blogTitle");
            
            blogDAO.deleteBlog(title);
            postDAO.deletePost(title);
        }
        response.sendRedirect("blog-manage");
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
