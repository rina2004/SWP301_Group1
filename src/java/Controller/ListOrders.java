/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

<<<<<<<< HEAD:src/java/controller/updateBlogController.java
import dal.BlogDAO;
import dal.PostDAO;
========
import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<<< HEAD:src/java/controller/updateBlogController.java
import java.io.IOException;
import java.io.PrintWriter;
import model.Blog;
import model.Post;
========
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Order;
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java

/**
 *
 * @author DUCDA
 */
<<<<<<<< HEAD:src/java/controller/updateBlogController.java

public class updateBlogController extends HttpServlet {

    PostDAO postDAO = new PostDAO();
    BlogDAO blogDAO = new BlogDAO();
========
public class ListOrders extends HttpServlet {
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java

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
<<<<<<<< HEAD:src/java/controller/updateBlogController.java
            out.println("<title>Servlet updateBlogController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateBlogController at " + request.getContextPath() + "</h1>");
========
            out.println("<title>Servlet ListOrders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListOrders at " + request.getContextPath() + "</h1>");
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java
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
<<<<<<<< HEAD:src/java/controller/updateBlogController.java
        String id = request.getParameter("id");

        Post post = postDAO.findById(id);
        Blog blog = blogDAO.findByPostID(id);

        String description = blog.getDescription();
        String content = post.getContent();
        request.setAttribute("description", description);
        request.setAttribute("content", content);
        request.setAttribute("post", post);
        request.getRequestDispatcher("updateblog.jsp").forward(request, response);
========

        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("acc"); // Giả sử session đang lưu object User

        if (user != null) {
            String userId = user.getId(); // Lấy ID của người dùng từ object User
            OrderDAO dao = new OrderDAO();
            List<Order> list = dao.getAllbyCustomerID(userId);
            request.setAttribute("list", list);
            request.getRequestDispatcher("view/ListOrder.jsp").forward(request, response);
        } else {
            response.sendRedirect("view/Login.jsp"); // Nếu chưa đăng nhập thì điều hướng về trang login
        }
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java
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
<<<<<<<< HEAD:src/java/controller/updateBlogController.java
        
        String id = request.getParameter("id");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");

        Post post = new Post(id, title, content);
        Blog blog = new Blog(id, title, description);

        postDAO.updatePost(post);
        blogDAO.updateBlog(blog);

        response.sendRedirect("blog-manage");
========
        processRequest(request, response);
>>>>>>>> khanhnguyentung:src/java/Controller/ListOrders.java
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
