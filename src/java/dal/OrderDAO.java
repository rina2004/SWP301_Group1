/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Order;

/**
 *
 * @author A A
 */
public class OrderDAO extends DBContext {

    public boolean createOrder(String flightId, String customerName, String customerEmail, String customerPhone) {
        String sql = "INSERT INTO `Order` (flightID, customerName, customerEmail, customerPhone, status, time) VALUES (?, ?, ?, ?, 'Pending', NOW())";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flightId);
            stm.setString(2, customerName);
            stm.setString(3, customerEmail);
            stm.setString(4, customerPhone);
            int affectedRows = stm.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

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

    public List<Order> getOrderHistory(String accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.customerID, o.staffID, o.status, o.time, COUNT(t.id) AS finalNum "
                + "FROM `Order` o "
                + "LEFT JOIN Ticket t ON o.id = t.orderId "
                + "WHERE o.customerID = ? "
                + "GROUP BY o.id, o.customerID, o.staffID, o.status, o.time "
                + "ORDER BY o.time DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));

                // Set Customer account (chỉ cần ID, có thể lazy load đầy đủ sau)
                Account customer = new Account();
                customer.setId(rs.getString("customerID"));
                order.setCustomer(customer);

                // Set Staff account (nếu có)
                Account staff = new Account();
                staff.setId(rs.getString("staffID"));
                order.setStaff(staff);

                order.setStatus(rs.getString("status"));
                order.setTime(rs.getTimestamp("time").toLocalDateTime());
                order.setFinalNum(rs.getInt("finalNum")); // Đổi từ ticket_count thành finalNum

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getOrderById(String orderId) {
        String sql = "SELECT id, customerID, staffID, status, time, finalPrice, finalNum FROM `Order` WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                AccountDAO accountDAO = new AccountDAO();
                Account customer = accountDAO.getUserByID(rs.getString("customerID"));
                Account staff = accountDAO.getUserByID(rs.getString("staffID"));

                return new Order(
                        rs.getString("id"),
                        customer,
                        staff,
                        rs.getString("status"),
                        rs.getTimestamp("time").toLocalDateTime(),
                        rs.getDouble("finalPrice"),
                        rs.getInt("finalNum")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error getting order: " + e.getMessage());
        }
        return null;
    }

}
