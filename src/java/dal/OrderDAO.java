/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.time.*;
import java.util.*;
import java.util.logging.*;
import model.Order;

/**
 *
 * @author A A
 */
public class OrderDAO extends DBContext{
    
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
                Order order = new Order();
                order.setId(rs.getString("id"));
                order.setStatus(rs.getString("status"));
                list.add(order);
            }
        } catch (SQLException e) {
            System.out.println(e);
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

        return -1; 
    }
}
