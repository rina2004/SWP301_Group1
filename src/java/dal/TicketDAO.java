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
import model.Account;
import model.Flight;
import model.Order;
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
                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setStatus(rs.getString("Status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        // If no ticket found, return default ticket
        Ticket defaultTicket = new Ticket();
        return defaultTicket;
    }

    public List<Ticket> getAllTicket() {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT t.*, f.airplaneID FROM Ticket t JOIN Flight f ON t.flightID = f.id";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                flight.setAirplaneId(rs.getString("airplaneID"));
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setOrder(order);
                ticket.setStatus(rs.getString("Status"));
                list.add(ticket);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Ticket getTicketById(String id) {
        String sql = "SELECT * FROM Ticket WHERE id=?";
        PreparedStatement stm;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setStatus(rs.getString("status"));
                return ticket;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String getTypeByID(String id) {
        PreparedStatement stm;
        String sql = "Select Type From Ticket where id = ?";
        ResultSet rs;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getString("type");
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Ticket> getTicketsByOrderID(String orderID) {
        PreparedStatement stm;
        String sql = "SELECT t.*, f.airplaneID FROM Ticket t JOIN Flight f ON t.flightID = f.id where orderID = ?";
        ResultSet rs;
        List<Ticket> list = new ArrayList<>();
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, orderID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                flight.setAirplaneId(rs.getString("airplaneID"));
                Order order = new Order();
                order.setId(rs.getString("orderID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setOrder(order);
                ticket.setStatus(rs.getString("Status"));
                list.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateTicketbySeatID(String ticketID, String seatID) {
        PreparedStatement stm;
        String sql = "Update Ticket Set seatID = ? , status = 'Checked' where id = ?";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            stm.setString(2, ticketID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
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

    public static void main(String[] args) {
        TicketDAO dao = new TicketDAO();
        String idt = "A001-B3-4";
        String id = dao.getIDbySeat(idt);
        System.out.println(id);

    }
}
