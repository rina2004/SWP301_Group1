/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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

    public List<Order> getOrdersByAccountId(String accountId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.id, o.status, o.time, COUNT(t.id) AS ticketCount "
                + "FROM [Order] o "
                + "LEFT JOIN Ticket t ON o.id = t.orderId "
                + "WHERE o.customerID = ? "
                + "GROUP BY o.id, o.status, o.time "
                + "ORDER BY o.time DESC";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, accountId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setStatus(rs.getString("status"));
                order.setTime(rs.getTimestamp("time").toLocalDateTime());
                order.setTicketCount(rs.getInt("ticketCount"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

}
