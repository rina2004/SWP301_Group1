/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Order;
import model.TicketType;

/**
 *
 * @author A A
 */
public class OrderDAO extends DBContext {

    public Order get(String id) {
        AccountDAO ad = new AccountDAO();
        TicketTypeDAO ttd = new TicketTypeDAO();
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
                        rs.getInt("finalNum"),
                        ttd.get(rs.getString("type")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Order> getAllbyCustomerID(String cusID) {
        String sql = "Select * From `Order` where customerID = ?";
        List<Order> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, cusID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getString("customerID"));
                TicketType type = new TicketType();
                type.setType(rs.getString("type"));
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setTime(rs.getTimestamp("time").toLocalDateTime());
                order.setStatus(rs.getString("status"));
                order.setFinalPrice(rs.getDouble("finalPrice"));
                order.setFinalNum(rs.getInt("finalNum"));
                order.setCustomer(acc);
                order.setTt(type);
                list.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);;
        }
        return list;
    }

    public int cancelOrderById(String orderId) {
        String sql = "UPDATE `Order` SET status = 'Processing' WHERE id = ? AND status != 'Cancelled'";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderId);
            return stm.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException e) {
            System.out.println("Error cancelling order: " + e.getMessage());
        }

        return -1; // Trả về -1 nếu có lỗi xảy ra
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        String cusID = "f6ab3243-0b1e-11f0-af18-047c163442e4";
        List<Order> list = dao.getAllbyCustomerID(cusID);

        for (Order order : list) {
            System.out.println(order.toString());
        }
    }
}
