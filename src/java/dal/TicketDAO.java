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
import model.Ticket;

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

    public List<Ticket> getTicketsByOrderId(String orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.*, f.name AS flightName, f.code AS flightCode, "
                + "f.startingTime, f.landingTime, "
                + "l1.name AS departureName, l2.name AS destinationName, "
                + "s.id AS seatCode, c.name AS compartmentName "
                + "FROM Ticket t "
                + "JOIN Flight f ON t.flightId = f.id "
                + "JOIN Location l1 ON f.departure = l1.id "
                + "JOIN Location l2 ON f.destination = l2.id "
                + "JOIN Seat s ON t.seatId = s.id "
                + "JOIN Compartment c ON s.compartmentId = c.id "
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

                    // Thêm các thông tin mở rộng
                    ticket.setFlightName(rs.getString("flightName"));
                    ticket.setFlightCode(rs.getString("flightCode"));
                    ticket.setStartingTime(rs.getTimestamp("startingTime").toLocalDateTime());
                    ticket.setLandingTime(rs.getTimestamp("landingTime").toLocalDateTime());
                    ticket.setDepartureName(rs.getString("departureName"));
                    ticket.setDestinationName(rs.getString("destinationName"));
                    ticket.setSeatCode(rs.getString("seatCode"));
                    ticket.setCompartmentName(rs.getString("compartmentName"));

                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

}
