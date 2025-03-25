/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Nation;
import model.OrderPassenger;
import model.Ticket;
import model.TicketType;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

    public Ticket getTicketByFlightId(String flightId) {
        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flightId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        rs.getString("orderId"),
                        rs.getString("flightID"),
                        rs.getString("seatId"),
                        rs.getString("type"),
                        rs.getDouble("Price"), // Changed from getInt to getDouble
                        rs.getString("Status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        // If no ticket found, return default ticket
        Ticket defaultTicket = new Ticket();
        defaultTicket.setPrice(0);
        defaultTicket.setType("Economy");
        return defaultTicket;
    }

    public List<Ticket> getAllTicket() {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Ticket(
                        rs.getString("id"),
                        rs.getString("orderId"),
                        rs.getString("flightID"),
                        rs.getString("seatId"),
                        rs.getString("type"),
                        rs.getDouble("Price"), // Changed from getInt to getDouble
                        rs.getString("Status")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Ticket getTicketById(String id) {
        String sql = "SELECT * FROM swp301.ticket WHERE id=?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        rs.getString("orderId"),
                        rs.getString("flightID"),
                        rs.getString("seatId"),
                        rs.getString("type"),
                        rs.getDouble("Price"), // Changed from getInt to getDouble
                        rs.getString("Status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<OrderPassenger> getPassengersByTicketId(String ticketId) {
        List<OrderPassenger> passengers = new ArrayList<>();
        String sql = "SELECT op.id, op.fullName, n.id AS nationId, n.name AS nationName "
                + "FROM OrderPassenger op "
                + "JOIN Nation n ON op.nationID = n.id "
                + "JOIN Ticket t ON op.id = t.orderPassengerID "
                + // 🔍 Liên kết hành khách với vé
                "WHERE t.id = ?";  // Chỉ lấy hành khách của vé cụ thể

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, ticketId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderPassenger passenger = new OrderPassenger();
                    passenger.setId(rs.getString("id"));
                    passenger.setFullName(rs.getString("fullName"));

                    Nation nation = new Nation();
                    nation.setId(rs.getInt("nationId"));
                    nation.setName(rs.getString("nationName"));

                    passenger.setNation(nation);

                    passengers.add(passenger);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return passengers;
    }

    public List<Ticket> getTicketsByOrderId(String orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.id, t.orderId, t.flightId, t.seatId, t.type, t.price, t.status, "
                + "f.name AS flightName, f.code AS flightCode, f.startingTime, f.landingTime, "
                + "l1.name AS departureName, l2.name AS destinationName, "
                + "s.id AS seatCode, c.name AS compartmentName, "
                + "tt.type AS ticketType, tt.handLuggageWeight, tt.checkedLuggageWeight, "
                + "tt.luggageQuantity, tt.additionalServices, "
                + "a.id AS airplaneId, a.name AS airplaneName "
                + "FROM Ticket t "
                + "JOIN Flight f ON t.flightId = f.id "
                + "JOIN Location l1 ON f.departure = l1.id "
                + "JOIN Location l2 ON f.destination = l2.id "
                + "JOIN Seat s ON t.seatId = s.id "
                + "JOIN Compartment c ON s.compartmentId = c.id "
                + "JOIN Airplane a ON c.airplaneId = a.id "
                + "JOIN TicketType tt ON t.type = tt.type "
                + "WHERE t.orderId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("id"));
                    ticket.setOrderId(rs.getString("orderId"));
                    ticket.setFlightId(rs.getString("flightId"));
                    ticket.setSeatId(rs.getString("seatId"));
                    ticket.setType(rs.getString("type"));
                    ticket.setPrice(rs.getDouble("price"));
                    ticket.setStatus(rs.getString("status"));

                    // Các thông tin mở rộng về chuyến bay
                    ticket.setFlightName(rs.getString("flightName"));
                    ticket.setFlightCode(rs.getString("flightCode"));
                    ticket.setStartingTime(rs.getTimestamp("startingTime").toLocalDateTime());
                    ticket.setLandingTime(rs.getTimestamp("landingTime").toLocalDateTime());
                    ticket.setDepartureName(rs.getString("departureName"));
                    ticket.setDestinationName(rs.getString("destinationName"));
                    ticket.setSeatCode(rs.getString("seatCode"));
                    ticket.setCompartmentName(rs.getString("compartmentName"));

                    // 🎟️ Tạo đối tượng TicketType và gán vào Ticket
                    TicketType ticketType = new TicketType();
                    ticketType.setType(rs.getString("ticketType"));
                    ticketType.setHandLuggageWeight(rs.getDouble("handLuggageWeight"));
                    ticketType.setCheckedLuggageWeight(rs.getDouble("checkedLuggageWeight"));
                    ticketType.setLuggageQuantity(rs.getInt("luggageQuantity"));
                    ticketType.setAdditionalServices(rs.getString("additionalServices"));

                    ticket.setTicketType(ticketType);

                    // Thông tin về máy bay
                    ticket.setAirplaneId(rs.getString("airplaneId"));
                    ticket.setAirplaneName(rs.getString("airplaneName"));

                    // 🎯 Gắn danh sách hành khách cho từng vé
                    ticket.setPassengers(getPassengersByTicketId(ticket.getId()));

                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public boolean cancelTicket(String ticketId) {
        String updateTicketSQL = "UPDATE swp301.ticket SET status = 'Cancelled' WHERE id = ?";
        String updateSeatSQL = "UPDATE swp301.seat SET status = TRUE WHERE id = ? AND reason IS NULL"; // Chỉ cập nhật nếu không có lý do bảo trì
        String checkOrderSQL = "SELECT COUNT(*) FROM swp301.ticket WHERE orderId = ? AND status != 'Cancelled'";
        String updateOrderSQL = "UPDATE swp301.order SET status = 'Cancelled' WHERE id = ?";
        String getOrderIdSQL = "SELECT orderId, seatId FROM swp301.ticket WHERE id = ?";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            String orderId = null;
            String seatId = null;

            // 1. Lấy orderId và seatId từ ticket
            try (PreparedStatement ps = connection.prepareStatement(getOrderIdSQL)) {
                ps.setString(1, ticketId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        orderId = rs.getString("orderId");
                        seatId = rs.getString("seatId");
                    } else {
                        return false; // Không tìm thấy vé
                    }
                }
            }

            // 2. Cập nhật trạng thái vé
            try (PreparedStatement ps = connection.prepareStatement(updateTicketSQL)) {
                ps.setString(1, ticketId);
                ps.executeUpdate();
            }

            // 3. Giải phóng ghế (nếu có)
            if (seatId != null) {
                try (PreparedStatement ps = connection.prepareStatement(updateSeatSQL)) {
                    ps.setString(1, seatId);
                    ps.executeUpdate();
                }
            }

            // 4. Kiểm tra xem còn vé nào chưa hoàn trong đơn hàng không
            boolean allTicketsRefunded = false;
            try (PreparedStatement ps = connection.prepareStatement(checkOrderSQL)) {
                ps.setString(1, orderId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        allTicketsRefunded = true;
                    }
                }
            }

            // 5. Nếu tất cả vé trong đơn hàng đã hoàn, cập nhật trạng thái đơn hàng
            if (allTicketsRefunded) {
                try (PreparedStatement ps = connection.prepareStatement(updateOrderSQL)) {
                    ps.setString(1, orderId);
                    ps.executeUpdate();
                }
            }

            connection.commit(); // Xác nhận transaction
            return true;
        } catch (SQLException e) {
            try {
                connection.rollback(); // Nếu có lỗi, quay lại trạng thái trước đó
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Khôi phục chế độ tự động commit
            } catch (SQLException autoCommitEx) {
                autoCommitEx.printStackTrace();
            }
        }
    }

}
