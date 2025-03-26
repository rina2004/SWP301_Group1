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
import model.Flight;
import model.Order;
import model.Ticket;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

    public Ticket getByFlightId(String flightID) {
        OrderDAO od = new OrderDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, flightID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        od.get(rs.getString("orderID")),
                        fd.getFlightById(rs.getString("flightID")),
                        sd.get(rs.getString("seatID")),
                        rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Ticket getByOrderId(String orderID) {
        OrderDAO od = new OrderDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE orderID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        od.get(rs.getString("orderID")),
                        fd.getFlightById(rs.getString("flightID")),
                        sd.get(rs.getString("seatID")),
                        rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Ticket getBySeatId(String seatID) {
        OrderDAO od = new OrderDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE seatID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, seatID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        od.get(rs.getString("orderID")),
                        fd.getFlightById(rs.getString("flightID")),
                        sd.get(rs.getString("seatID")),
                        rs.getString("status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Ticket> list() {
        OrderDAO od = new OrderDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Ticket(
                        rs.getString("id"),
                        od.get(rs.getString("orderID")),
                        fd.getFlightById(rs.getString("flightID")),
                        sd.get(rs.getString("seatID")),
                        rs.getString("status")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Ticket> getTicketsByOrderID(String orderID) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT t.* FROM Ticket t WHERE t.orderID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderID);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(orderID);

                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("id"));
                    ticket.setOrder(order);
                    ticket.setStatus(rs.getString("status"));

                    list.add(ticket);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách vé theo OrderID: " + orderID, e);
        }
        return list;
    }

    public void updateTicketbySeatID(String ticketID, String seatID) {
        PreparedStatement stm;
        String sql = "Update Ticket Set seatID = ? , status = 'Checked' where id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public String getIDbySeat(String seatid) {
        PreparedStatement stm;
        ResultSet rs;
        String ticketId = null;
        String sql = "Select t.id From Ticket t Join Seat s On s.id = t.seatID where s.id = ? ";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatid);
            rs = stm.executeQuery();
            if (rs.next()) {
                ticketId = rs.getString("id");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return ticketId;
    }

    public Ticket getInfor(String ticketId) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Select * From Ticket where id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, ticketId);
            rs = stm.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setOrder(order);
                ticket.setStatus(rs.getString("status"));

                return ticket;

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        TicketDAO ticketDAO = new TicketDAO(); // Cần chắc chắn rằng TicketDAO đã khởi tạo connection đúng cách
        String orderID = "ORD002"; // Thay bằng OrderID thực tế trong database

        List<Ticket> tickets = ticketDAO.getTicketsByOrderID(orderID);

        if (tickets.isEmpty()) {
            System.out.println("Không tìm thấy vé nào cho OrderID: " + orderID);
        } else {
            System.out.println("Danh sách vé:");
            for (Ticket t : tickets) {
                System.out.println("Ticket ID: " + t.getId() + ", Status: " + t.getStatus());
            }
        }
    }
}
