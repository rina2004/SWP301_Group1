/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.logging.*;
import model.*;

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

        return -1;
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

    public boolean updateStatus(Order order) {
        String sql = "UPDATE swp301.order SET status = ? WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, order.getStatus());
            stm.setString(2, order.getId());
            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void insert(Order order) {
        AccountDAO ad = new AccountDAO();
        Account staff1 = ad.getAccountByUsername("staff1");
        String sql = "INSERT INTO swp301.order (id, customerID, staffID, status, time, finalPrice, finalNum, type) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, order.getId());
            stm.setString(2, order.getCustomer().getId());
            stm.setString(3, staff1.getId());
            stm.setString(4, order.getStatus());
            stm.setTimestamp(5, Timestamp.valueOf(order.getTime()));
            stm.setDouble(6, order.getFinalPrice());
            stm.setInt(7, order.getFinalNum());
            if (order.getTt() != null) {
                stm.setString(8, order.getTt().getType());
            } else {
                stm.setNull(8, java.sql.Types.VARCHAR);
            }
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
