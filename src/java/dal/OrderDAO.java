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
import model.Order;

/**
 *
 * @author A A
 */
public class OrderDAO extends DBContext{
    
    public boolean createOrder(String flightId, String customerName, String customerEmail, String customerPhone) {
        String sql = "INSERT INTO `Order` (flightID, customerName, customerEmail, customerPhone, status, time) VALUES (?, ?, ?, ?, 'Pending', NOW())";
        PreparedStatement stm = null;
        try{
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
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setStatus(rs.getString("status"));
                list.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);;
        }
        return list;
    }
    
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        String cusID = "f2738d94-097f-11f0-af18-047c163442e4";
        List<Order> list = dao.getAllbyCustomerID(cusID);
        
        for (Order order : list) {
            System.out.println(order.toString());
        }
    }
}
