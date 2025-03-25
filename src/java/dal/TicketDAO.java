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
        try (PreparedStatement stm = connection.prepareStatement(sql)){
            stm.setString(1,  flightID);
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
        try (PreparedStatement stm = connection.prepareStatement(sql)){
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
        try (PreparedStatement stm = connection.prepareStatement(sql)){
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
        try (PreparedStatement stm = connection.prepareStatement(sql)){
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
}