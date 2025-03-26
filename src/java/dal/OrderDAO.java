/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;

/**
 *
 * @author A A
 */
public class OrderDAO extends DBContext{
    
    public Order get(String id) {
        AccountDAO ad = new AccountDAO();
        String sql = "SELECT * FROM swp301.order WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Order(rs.getString("id"),
                        ad.getUserByID("customerID"),
                        ad.getUserByID("staffID"),
                        rs.getString("status"),
                        rs.getTimestamp("time").toLocalDateTime(),
                        rs.getDouble("finalPrice"),
                        rs.getInt("finalNum"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
