/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.ChatMessage;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rinaaaa
 */
public class ChatDAO extends DBContext {
//    public void saveMessage(ChatMessage message) {
//        String sql = "INSERT INTO ChatMessage (id, senderID, receiverID, message, timestamp, isRead) VALUES (?, ?, ?, ?, ?, ?)";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, message.getId());
//            ps.setString(2, message.getSenderID());
//            ps.setString(3, message.getReceiverID());
//            ps.setString(4, message.getMessage());
//            ps.setTimestamp(5, message.getTimestamp());
//            ps.setBoolean(6, message.isRead());
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            Logger.getLogger(ChatDAO.class.getName()).log(Level.SEVERE, null, e);
//        }
//    }
//
//    public List<ChatMessage> getMessages(String userID, String contactID) {
//        List<ChatMessage> messages = new ArrayList<>();
//        String sql = "SELECT * FROM ChatMessage WHERE (senderID = ? AND receiverID = ?) OR (senderID = ? AND receiverID = ?) ORDER BY timestamp";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, userID);
//            ps.setString(2, contactID);
//            ps.setString(3, contactID);
//            ps.setString(4, userID);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                messages.add(new ChatMessage(rs.getString("id"), rs.getString("senderID"), rs.getString("receiverID"), rs.getString("message"), rs.getTimestamp("timestamp"), rs.getBoolean("isRead")));
//            }
//        } catch (SQLException e) {
//            Logger.getLogger(ChatDAO.class.getName()).log(Level.SEVERE, null, e);
//        }
//        return messages;
//    }
//
//    public void markMessagesAsRead(String senderID, String receiverID) {
//        String sql = "UPDATE ChatMessage SET isRead = TRUE WHERE senderID = ? AND receiverID = ? AND isRead = FALSE";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setString(1, senderID);
//            ps.setString(2, receiverID);
//            ps.executeUpdate();
//        } catch (SQLException e) {
//            Logger.getLogger(ChatDAO.class.getName()).log(Level.SEVERE, null, e);
//        }
//    }
}
