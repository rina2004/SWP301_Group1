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
import model.Seat;
import model.Ticket;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

    public Ticket getTicketByFlightId(String flightId) {
        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, flightId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                Seat seat = new Seat();
                seat.setId(rs.getString("seatID"));
                return new Ticket(
                        rs.getString("id"),
                        order,
                        seat,
                        rs.getString("type"),
                        rs.getString("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Ticket> getAllTicket() {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("orderID"));

                Seat seat = new Seat();
                seat.setId(rs.getString("seatID"));

                list.add(new Ticket(
                        rs.getString("id"),
                        order,
                        seat,
                        rs.getString("type"),
                        rs.getString("status")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Ticket getTicketById(String id) {
        String sql = "SELECT * FROM swp301.ticket WHERE id=?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                Seat seat = new Seat();
                seat.setId(rs.getString("seatID"));
                return new Ticket(
                        rs.getString("id"),
                        order,
                        seat,
                        rs.getString("type"),
                        rs.getString("status")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
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

    public List<Ticket> getTicketsByOrderID(String orderID) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT t.*, f.airplaneID FROM Ticket t JOIN Flight f ON t.flightID = f.id WHERE t.orderID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderID);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setId(orderID);

                    Flight flight = new Flight();
                    flight.setId(rs.getString("flightID"));

                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("id"));
                    ticket.setOrder(order);
                    ticket.setType(rs.getString("type"));
                    ticket.setStatus(rs.getString("status"));

                    list.add(ticket);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy danh sách vé theo OrderID: " + orderID, e);
        }
        return list;
    }

    public static void main(String[] args) {
        TicketDAO ticketDAO = new TicketDAO();

        // Thử với OrderID cụ thể
        String testOrderID = "ORD001";  // Thay bằng orderID thực tế trong DB
        List<Ticket> tickets = ticketDAO.getTicketsByOrderID(testOrderID);

        // In kết quả ra màn hình
        if (tickets.isEmpty()) {
            System.out.println("Không tìm thấy vé nào cho OrderID: " + testOrderID);
        } else {
            System.out.println("Danh sách vé cho OrderID: " + testOrderID);
            for (Ticket ticket : tickets) {
                System.out.println("Ticket ID: " + ticket.getId()
                        + ", Type: " + ticket.getType()
                        + ", Status: " + ticket.getStatus());
            }
        }
    }
}
