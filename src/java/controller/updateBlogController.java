/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.*;
import model.*;

/**
 *
 * @author DUCDA
 */

public class updateBlogController extends HttpServlet {

    PostDAO postDAO = new PostDAO();
    BlogDAO blogDAO = new BlogDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        Post post = postDAO.findById(id);
        Blog blog = blogDAO.findByPostID(id);

        String description = blog.getDescription();
        String content = post.getContent();
        request.setAttribute("description", description);
        request.setAttribute("content", content);
        request.setAttribute("post", post);
        request.getRequestDispatcher("updateblog.jsp").forward(request, response);
    }
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String content = request.getParameter("content");

        Post post = new Post(id, title, content);
        Blog blog = new Blog(id, title, description);

        postDAO.updatePost(post);
        blogDAO.updateBlog(blog);

        response.sendRedirect("blog-manage");
    }
}