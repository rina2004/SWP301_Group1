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
import model.Airplane;
import model.Compartment;
import model.Flight;
import model.Location;
import model.Nation;
import model.Order;
import model.OrderPassenger;
import model.Seat;
import model.Ticket;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

//    public Ticket getByFlightId(String flightID) {
//        OrderDAO od = new OrderDAO();
//        SeatDAO sd = new SeatDAO();
//        FlightDAO fd = new FlightDAO();
//        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
//        try (PreparedStatement stm = connection.prepareStatement(sql)) {
//            stm.setString(1, flightID);
//            ResultSet rs = stm.executeQuery();
//            if (rs.next()) {
//                return new Ticket(
//                        rs.getString("id"),
//                        od.get(rs.getString("orderID")),
//                        fd.getFlightById(rs.getString("flightID")),
//                        sd.get(rs.getString("seatID")),
//                        rs.getString("status"));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    public Ticket getByOrderId(String orderID) {
//        OrderDAO od = new OrderDAO();
//        SeatDAO sd = new SeatDAO();
//        FlightDAO fd = new FlightDAO();
//        String sql = "SELECT * FROM swp301.ticket WHERE orderID = ? ORDER BY price ASC LIMIT 1";
//        try (PreparedStatement stm = connection.prepareStatement(sql)) {
//            stm.setString(1, orderID);
//            ResultSet rs = stm.executeQuery();
//            if (rs.next()) {
//                return new Ticket(
//                        rs.getString("id"),
//                        od.get(rs.getString("orderID")),
//                        fd.getFlightById(rs.getString("flightID")),
//                        sd.get(rs.getString("seatID")),
//                        rs.getString("status"));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    public Ticket getBySeatId(String seatID) {
//        OrderDAO od = new OrderDAO();
//        SeatDAO sd = new SeatDAO();
//        FlightDAO fd = new FlightDAO();
//        String sql = "SELECT * FROM swp301.ticket WHERE seatID = ? ORDER BY price ASC LIMIT 1";
//        try (PreparedStatement stm = connection.prepareStatement(sql)) {
//            stm.setString(1, seatID);
//            ResultSet rs = stm.executeQuery();
//            if (rs.next()) {
//                return new Ticket(
//                        rs.getString("id"),
//                        od.get(rs.getString("orderID")),
//                        fd.getFlightById(rs.getString("flightID")),
//                        sd.get(rs.getString("seatID")),
//                        rs.getString("status"));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return null;
//    }
//
//    public List<Ticket> list() {
//        OrderDAO od = new OrderDAO();
//        SeatDAO sd = new SeatDAO();
//        FlightDAO fd = new FlightDAO();
//        List<Ticket> list = new ArrayList<>();
//        String sql = "SELECT * FROM swp301.ticket";
//        try (PreparedStatement stm = connection.prepareStatement(sql)) {
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                list.add(new Ticket(
//                        rs.getString("id"),
//                        od.get(rs.getString("orderID")),
//                        fd.getFlightById(rs.getString("flightID")),
//                        sd.get(rs.getString("seatID")),
//                        rs.getString("status")));
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return list;
//    }

    public List<OrderPassenger> getPassengersByFlightAndSeat(String flightId, String seatId) {
        List<OrderPassenger> passengers = new ArrayList<>();
        String sql = "SELECT op.id, op.fullName, n.id AS nationId, n.name AS nationName "
                + "FROM OrderPassenger op "
                + "JOIN Nation n ON op.nationID = n.id "
                + "JOIN `Order` o ON op.orderID = o.id "
                + "JOIN Ticket t ON t.orderID = o.id "
                + "WHERE t.flightID = ? AND t.seatID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, flightId);
            ps.setString(2, seatId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderPassenger passenger = new OrderPassenger();
                    passenger.setId(rs.getString("id"));
                    passenger.setName(rs.getString("fullName"));

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
        return passengers; // Trả về danh sách hành khách
    }

    public List<Ticket> getTicketsByOrderId(String orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT \n"
                + "    t.id AS ticketId, \n"
                + "    t.status AS ticketStatus, \n"
                + "    o.id AS orderId, \n"
                + "    o.customerID, \n"
                + "    o.staffID, \n"
                + "    o.status AS orderStatus, \n"
                + "    o.time, \n"
                + "    o.finalPrice, \n"
                + "    o.finalNum, \n"
                + "    f.id AS flightId, \n"
                + "    f.name AS flightName, \n"
                + "    f.code, \n"
                + "    f.airplaneID, \n"
                + "    a.name AS airplaneName, -- Lấy tên máy bay từ bảng Airplane\n"
                + "    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID\n"
                + "    des.name AS destination, -- Lấy tên địa điểm thay vì ID\n"
                + "    f.entryTime, \n"
                + "    f.startingTime, \n"
                + "    f.landingTime, \n"
                + "    s.id AS seatId, \n"
                + "    s.status AS seatStatus, \n"
                + "    s.reason \n"
                + "FROM Ticket t \n"
                + "JOIN `Order` o ON t.orderID = o.id \n"
                + "JOIN Flight f ON t.flightID = f.id \n"
                + "JOIN Seat s ON t.seatID = s.id \n"
                + "JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên\n"
                + "JOIN Location des ON f.destination = des.id -- Thay ID bằng tên\n"
                + "JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay\n"
                + "WHERE t.orderID = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Tạo các đối tượng như Airplane, Flight, Location, Compartment, Seat, Order, Ticket
                    Airplane airplane = new Airplane();
                    airplane.setName(rs.getString("airplaneName"));

                    Flight flight = new Flight();
                    flight.setId(rs.getString("flightId"));
                    flight.setName(rs.getString("flightName"));
                    flight.setCode(rs.getString("code"));
                    flight.setAirplane(airplane);
                    flight.setEntryTime(rs.getTimestamp("entryTime") != null ? rs.getTimestamp("entryTime").toLocalDateTime() : null);
                    flight.setStartingTime(rs.getTimestamp("startingTime") != null ? rs.getTimestamp("startingTime").toLocalDateTime() : null);
                    flight.setLandingTime(rs.getTimestamp("landingTime") != null ? rs.getTimestamp("landingTime").toLocalDateTime() : null);

                    Location departure = new Location();
                    departure.setName(rs.getString("departure"));
                    flight.setDeparture(departure);

                    Location destination = new Location();
                    destination.setName(rs.getString("destination"));
                    flight.setDestination(destination);

                    Compartment compartment = new Compartment();

                    Seat seat = new Seat();
                    seat.setId(rs.getString("seatId"));
                    seat.setCompartment(compartment);
                    seat.setStatus(rs.getString("seatStatus"));

                    Order order = new Order();
                    order.setId(rs.getString("orderId"));
                    order.setStatus(rs.getString("orderStatus"));
                    order.setTime(rs.getTimestamp("time").toLocalDateTime());
                    order.setFinalPrice(rs.getDouble("finalPrice"));
                    order.setFinalNum(rs.getInt("finalNum"));

                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("ticketId"));
                    ticket.setOrder(order);
                    ticket.setFlight(flight);
                    ticket.setSeat(seat);
                    ticket.setStatus(rs.getString("ticketStatus"));

                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public int updateTicketsByOrder(String orderID, String newStatus) {
        String sql = "UPDATE Ticket SET status = ? WHERE orderID = ? AND status NOT IN ('Cancelled', 'Pending')";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, newStatus);
            stm.setString(2, orderID);
            return stm.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

}
