package controller;
import dal.*;
import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.logging.*;
import model.*;

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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addblog.jsp").forward(request, response);
    }
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


}
