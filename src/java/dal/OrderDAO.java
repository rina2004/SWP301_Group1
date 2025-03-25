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

    public List<Order> getAll() {
        String sql = "Select * From `Order`";
        List<Order> list = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;

        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setStatus(rs.getString("status"));
                order.setTime(rs.getDate("time"));
                list.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);;
        }
        return list;
    }
    
    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
        List<Order> list = dao.getAll();
        
        for (Order order : list) {
            System.out.println(order.toString());
        }
    }
}
