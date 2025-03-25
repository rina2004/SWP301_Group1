/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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

    public List<Order> getOrderHistory(String accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.customerID, o.staffID, o.status, o.time, COUNT(t.id) AS ticket_count "
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

                // Set Customer account (chỉ cần id, có thể lazy load full sau)
                Account customer = new Account();
                customer.setId(rs.getString("customerID"));
                order.setCustomerID(customer);

                // Set Staff account (nếu cần)
                Account staff = new Account();
                staff.setId(rs.getString("staffID"));
                order.setStaffID(staff);

                order.setStatus(rs.getString("status"));
                order.setTime(rs.getTimestamp("time").toLocalDateTime());
                order.setTicketCount(rs.getInt("ticket_count"));

                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getPendingCancelRequests() {
        String sql = "SELECT id, customerID, staffID, status, time, ticketCount "
                + "FROM `Order` WHERE status = 'Processing'";
        List<Order> orders = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));

                Account customer = new Account();
                customer.setId(rs.getString("customerID"));
                order.setCustomerID(customer);

                Account staff = new Account();
                staff.setId(rs.getString("staffID"));
                order.setStaffID(staff);

                order.setStatus(rs.getString("status"));
                order.setTime(rs.getTimestamp("time").toLocalDateTime());
                order.setTicketCount(rs.getInt("ticketCount")); // Dùng đúng tên trường

                orders.add(order);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public boolean approveCancelRequest(String orderId) {
        String sql = "UPDATE `Order` SET status = 'Cancelled' WHERE id = ? AND status = 'Processing'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

}
