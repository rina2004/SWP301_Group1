package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

public class BlogDAO extends DBContext<Blog> {
    
    public void insertBlog(Blog blog) {
        String sql = "INSERT INTO Blog (id, title, image, descripion, categoryID) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getId());
            ps.setString(2, blog.getTitle());
            ps.setString(3, blog.getImage());
            ps.setString(4, blog.getDescription());
            ps.setInt(5, blog.getCategoryID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateBlog(Blog blog) {
        String sql = "UPDATE Blog SET title = ?, image = ?, descripion = ?, categoryID = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getImage());
            ps.setString(4, blog.getDescription());
            ps.setInt(4, blog.getCategoryID());
            ps.setString(5, blog.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteBlog(String id) {
        String sql = "DELETE FROM Blog WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Blog getBlogById(String id) {
        String sql = "SELECT * FROM Blog WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Blog(
                    rs.getString("id"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("descripion"),
                    rs.getInt("categoryID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT * FROM blog";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Blog(
                    rs.getString("id"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("description"),
                    rs.getInt("categoryID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public static void main(String[] args) {
        for(Blog blog : new BlogDAO().getAllBlogs()){
            System.out.println(blog);
        }
    }

    @Override
    public void insert(Blog model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(Blog model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(Blog model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<Blog> list() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}