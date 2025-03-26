/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import model.Comment;
import model.Post;

/**
 *
 * @author DUCDA
 */
public class postController extends HttpServlet {

    PostDAO postDAO = new PostDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
//        Post post = postDAO.findById(id);
//        
//        List<Comment> listCmt = postDAO.findCmt(id);
//        
//        request.setAttribute("post", post);
//        request.setAttribute("listCmt", listCmt);
        request.getRequestDispatcher("post.jsp").forward(request, response);
    }
}
