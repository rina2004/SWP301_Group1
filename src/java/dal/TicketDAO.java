/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import model.*;
/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

    public Ticket getByFlightId(String flightID) {
        OrderPassengerDAO opd = new OrderPassengerDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, flightID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
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
        OrderPassengerDAO opd = new OrderPassengerDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE orderID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
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
        OrderPassengerDAO opd = new OrderPassengerDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE seatID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, seatID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
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
        OrderPassengerDAO opd = new OrderPassengerDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
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
    String sql = "SELECT t.id, t.status, f.airplaneID, t.flightID " +
                 "FROM Ticket t " +
                 "JOIN Flight f ON t.flightID = f.id " +
                 "WHERE t.orderID = ?";

    try (PreparedStatement stm = connection.prepareStatement(sql)) {
        stm.setString(1, orderID);
        try (ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                OrderPassenger orderP = new OrderPassenger();
                orderP.setId(orderID);

                Airplane airplane = new Airplane();
                airplane.setId(rs.getString("airplaneID"));

                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                flight.setAirplane(airplane);

                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setOrderP(orderP);
                ticket.setFlight(flight);
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
            stm.setString(2, ticketID);
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
        ;
        String sql = "Select * From Ticket where id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql);){
            stm.setString(1, ticketId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                OrderPassenger orderP = new OrderPassenger();
                orderP.setId(rs.getString("orderPID"));
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setOrderP(orderP);
                ticket.setStatus(rs.getString("status"));
                return ticket;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
