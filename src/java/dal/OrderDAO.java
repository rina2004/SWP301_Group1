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
import model.OrderPassenger;

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


    public List<Order> getOrderHistory(String accountId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.customerID, o.staffID, o.status, o.time, o.finalPrice, COUNT(t.id) AS finalNum "
                + "FROM `Order` o "
                + "LEFT JOIN OrderPassenger op ON o.id = op.orderID "
                + "LEFT JOIN Ticket t ON op.id = t.orderPID "
                + "WHERE o.customerID = ? "
                + "GROUP BY o.id, o.customerID, o.staffID, o.status, o.time, o.finalPrice "
                + "ORDER BY o.time DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, accountId);
            try (ResultSet rs = ps.executeQuery()) {
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
                    order.setFinalPrice(rs.getDouble("finalPrice"));
                    order.setFinalNum(rs.getInt("finalNum"));

                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<OrderPassenger> getPassengersByOrderId(String orderId) {
        String sql = "SELECT * FROM OrderPassenger WHERE orderID = ?";
        List<OrderPassenger> passengers = new ArrayList<>();

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    OrderPassenger passenger = new OrderPassenger();
                    passenger.setId(rs.getString("id"));
                    passenger.setName(rs.getString("fullName"));
                    passengers.add(passenger);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching passengers: " + e.getMessage());
        }

        return passengers;
    }

    public int cancelTicketsByOrderPassengerId(String orderPassengerId) {
        String sql = "UPDATE Ticket SET status = 'Processing' WHERE orderPID = ? AND status != 'Cancelled'";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderPassengerId);
            return stm.executeUpdate(); // Trả về số vé bị hủy
        } catch (SQLException e) {
            System.out.println("Error cancelling tickets: " + e.getMessage());
        }

        return -1; // Lỗi xảy ra
    }

   

    public int updateOrderStatus(String orderId, String status) {
        String sql = "UPDATE `Order` SET status = ? WHERE id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, status);
            stm.setString(2, orderId);
            return stm.executeUpdate(); // Trả về số Order bị cập nhật
        } catch (SQLException e) {
            System.out.println("Error updating order status: " + e.getMessage());
        }

        return -1; // Lỗi xảy ra
    }

    public String getOrderIdByOrderPassengerId(String orderPassengerId) {
        String sql = "SELECT orderID FROM OrderPassenger WHERE id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderPassengerId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("orderID"); // Trả về OrderID nếu tìm thấy
                }
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving order ID: " + e.getMessage());
        }

        return null; // Không tìm thấy OrderID hoặc lỗi xảy ra
    }

}
