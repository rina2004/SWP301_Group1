package dal;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

public class BlogDAO extends DBContext {

<<<<<<< HEAD
//    public void insertBlog(Blog blog) {
//        String sql = "INSERT INTO Blog (id, postID, title, description, image, categoryID) VALUES (?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, blog.getId());
//            ps.setString(2, blog.getPostID());
//            ps.setString(3, blog.getTitle());
//            ps.setString(4, blog.getDescription());
//            ps.setString(5, blog.getImage());
//            ps.setString(6, blog.getCategoryID());
////          ps.setString(7, blog.getCreate_at());
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }

//    public void updateBlog(Blog blog) {
//        String sql = "UPDATE Blog SET postID = ?, title = ?, description = ?, image = ?, categoryID = ? WHERE id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, blog.getPostID());
//            ps.setString(2, blog.getTitle());
//            ps.setString(3, blog.getDescription());
//            ps.setString(4, blog.getImage());
//            ps.setString(5, blog.getCategoryID());
////          ps.setString(6, blog.getCreate_at());
//            ps.setString(6, blog.getId());
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//    }
=======
    public void insertBlog(Blog blog) {
        String sql = "INSERT INTO Blog (postID, title, description, image, categoryID, authorID) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getPostID());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getDescription());
            ps.setString(4, blog.getImage());
            ps.setString(5, blog.getCategoryID());
            ps.setString(6, blog.getAuthorID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateBlog(Blog blog) {
        String sql = "UPDATE Blog SET title = ?, description = ? WHERE postID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getDescription());
            ps.setString(3, blog.getPostID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
>>>>>>> ducda

    public void deleteBlog(String title) {
        String sql = "DELETE FROM Blog WHERE title = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

<<<<<<< HEAD
//    public List<Blog> searchBlogs(String keyword, int page) {
//        List<Blog> blogs = new ArrayList<>();
//        String sql = "SELECT * FROM blog WHERE title LIKE ?\n"
//                + "order by id\n"
//                + "limit 4 offset ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, "%" + keyword + "%");
//            ps.setInt(2, 4 * (page - 1));
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                blogs.add(new Blog(
//                        rs.getString("id"),
//                        rs.getString("postID"),
//                        rs.getString("title"),
//                        rs.getString("description"),
//                        rs.getString("image"),
//                        rs.getString("categoryID")
//                //      rs.getString("create_at")
//                ));
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return blogs;
//    }

//    public List<Blog> getAllBlogs(int page) {
//        List<Blog> list = new ArrayList<>();
//        String sql = "SELECT * FROM blog\n"
//                + "order by id\n"
//                + "limit 4 offset ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, 4 * (page - 1));
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                list.add(new Blog(
//                        rs.getString("id"),
//                        rs.getString("postID"),
//                        rs.getString("title"),
//                        rs.getString("description"),
//                        rs.getString("image"),
//                        rs.getString("categoryID")
//                //      rs.getString("create_at")
//                ));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
//
//    public int findTotalRecordByKeyWord(String keyword) {
//        int totalRecord = 0;
//        String sql = "SELECT count(*) FROM blog WHERE title LIKE ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, "%" + keyword + "%");
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    totalRecord = rs.getInt(1); // Lấy giá trị đếm từ kết quả truy vấn
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return totalRecord;
//    }
=======
    public List<Blog> searchBlogs(String keyword, int page) {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT * FROM blog WHERE title LIKE ?\n"
                + "order by id\n"
                + "limit 4 offset ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, 4 * (page - 1));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                blogs.add(new Blog(rs.getString("id"),
                        rs.getString("postID"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getString("categoryID"),
                        rs.getString("authorID")
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public List<Blog> getAllBlogs(int page) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM blog\n"
                + "order by id\n"
                + "limit 4 offset ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, 4 * (page - 1));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getString("id"),
                        rs.getString("postID"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getString("categoryID"),
                        rs.getString("authorID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int findTotalRecordByKeyWord(String keyword) {
        int totalRecord = 0;
        String sql = "SELECT count(*) FROM blog WHERE title LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalRecord = rs.getInt(1); // Lấy giá trị đếm từ kết quả truy vấn
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }
>>>>>>> ducda

    public int findAllTotalRecord() {
        int totalRecord = 0;
        String sql = "SELECT count(*) FROM blog";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    totalRecord = rs.getInt(1); // Lấy giá trị đếm từ kết quả truy vấn
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }

<<<<<<< HEAD
//    public List<Blog> getAllBlog() {
//        List<Blog> list = new ArrayList<>();
//        String sql = "SELECT * FROM blog";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                list.add(new Blog(
//                        rs.getString("id"),
//                        rs.getString("postID"),
//                        rs.getString("title"),
//                        rs.getString("description"),
//                        rs.getString("image"),
//                        rs.getString("categoryID")
//                //      rs.getString("create_at")
//                ));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
=======
    public List<Blog> get4FirstBlog() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM blog LIMIT 4";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Blog(rs.getString("id"),
                        rs.getString("postID"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getString("categoryID"),
                        rs.getString("authorID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Blog findByPostID(String id) {
        Blog blog = null;
        String sql = "SELECT * FROM blog WHERE postID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                blog = new Blog(
                        rs.getString("id"),
                        rs.getString("postID"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getString("categoryID"),
                        rs.getString("authorID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi phù hợp
        }
        return blog;
    }
>>>>>>> ducda
}