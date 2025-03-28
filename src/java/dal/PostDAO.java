/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.*;
import model.*;

/**
 *
 * @author DUCDA
 */
public class PostDAO extends DBContext {

    public Post findById(String id) {
        Post post = null;
        String sql = "SELECT * FROM blogpost WHERE id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                post = new Post(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getString("authorID"),
                        rs.getString("categoryID"),
                        rs.getBoolean("published")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi phù hợp
        }
        return post;
    }
    
    public Post findByTitle(String title) {
        Post post = null;
        String sql = "SELECT * FROM blogpost WHERE title = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, title);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                post = new Post(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("content"),
                        rs.getString("image"),
                        rs.getString("authorID"),
                        rs.getString("categoryID"),
                        rs.getBoolean("published")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý lỗi phù hợp
        }
        return post;
    }

    public List<Comment> findCmt(String id) {
        List<Comment> cmt = new ArrayList<>();
        String sql = "SELECT comment.id, account.name AS author, comment.content, comment.postID\n"
                + "FROM comment\n"
                + "JOIN account ON comment.accountID = account.id\n"
                + "WHERE comment.postID = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql)){
            ps.setString(1, id);
            try(ResultSet rs = ps.executeQuery()){
                while (rs.next()) {
                    cmt.add(new Comment(
                            rs.getString("id"),
                            rs.getString("author"),
                            rs.getString("content"),
                            rs.getString("postID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cmt;
    }
    public void addComment(Comment comment) {
        String sql = "INSERT INTO comment (accountID, content, postID) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, comment.getAccount());
            ps.setString(2, comment.getContent());
            ps.setString(3, comment.getPost());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void insertPost(Post post) {
        String sql = "INSERT INTO blogpost (title, content, image, authorID, categoryID, published) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getImage());
            ps.setString(4, post.getAuthorID());
            ps.setString(5, post.getCategoryID());
            ps.setBoolean(6, post.isPublished());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void deletePost(String title) {
        String sql = "DELETE FROM blogpost WHERE title = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void updatePost(Post post) {
        String sql = "UPDATE blogpost SET title = ?, content = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setString(3, post.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
