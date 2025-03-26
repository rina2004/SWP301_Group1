/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Comment;
import model.Post;

/**
 *
 * @author DUCDA
 */
public class PostDAO extends DBContext {

//    public Post findById(String id) {
//        Post post = null;
//        String sql = "SELECT * FROM blogpost WHERE id = ?";
//
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, id);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                post = new Post(
//                        rs.getString("id"),
//                        rs.getString("title"),
//                        rs.getString("content"),
//                        rs.getString("image"),
//                        rs.getString("authorID"),
//                        rs.getBoolean("published")
//                );
//            }
//        } catch (SQLException e) {
//            e.printStackTrace(); // Xử lý lỗi phù hợp
//        }
//        return post;
//    }
//
//    public List<Comment> findCmt(String id) {
//        List<Comment> cmt = new ArrayList<>();
//        String sql = "SELECT comment.id, account.name AS author, comment.content\n"
//                + "FROM comment\n"
//                + "JOIN account ON comment.accountID = account.id\n"
//                + "WHERE comment.postID = ?";
//        try(PreparedStatement ps = connection.prepareStatement(sql)){
//            ps.setString(1, id);
//            try(ResultSet rs = ps.executeQuery()){
//                while (rs.next()) {
//                    cmt.add(new Comment(
//                            rs.getString("id"),
//                            rs.getString("author"),
//                            rs.getString("content")
//                    ));
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return cmt;
//    }

}
