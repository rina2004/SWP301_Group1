/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import dal.PostDAO;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Blog;
import model.Post;

/**
 *
 * @author DUCDA
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class addBlogController extends HttpServlet {

    private static final String SAVE_DIR = "E:\\Project_Java\\SWP301_Group1\\web\\img"; // Thư mục có sẵn
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
            out.println("<title>Servlet addBlogController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addBlogController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("addblog.jsp").forward(request, response);
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
        File saveDir = new File(SAVE_DIR);
        if (!saveDir.exists()) {
            saveDir.mkdir(); // Tạo thư mục nếu chưa có
        }

        HttpSession session = request.getSession();

        Account acc = (Account) session.getAttribute("acc");
        String accid = acc.getId();

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");
        String categoryID = "1";
        String image = null;
        // Lấy file từ request
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String contentDisp = filePart.getHeader("content-disposition");
            for (String contentItem : contentDisp.split(";")) {
                if (contentItem.trim().startsWith("filename")) {
                    image = contentItem.substring(contentItem.indexOf("=") + 2, contentItem.length() - 1);
                    break;
                }
            }

            // Lưu file ảnh vào thư mục đã chỉ định
            if (image != null && !image.isEmpty()) {
                filePart.write(SAVE_DIR + File.separator + image);
            }
        }

        Post post = new Post(title, content, image, accid, categoryID, true);
        postDAO.insertPost(post);

        post = postDAO.findByTitle(title);
        String postId = post.getId();

        Blog blog = new Blog(postId, title, description, image, categoryID, accid);
        blogDAO.insertBlog(blog);

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
