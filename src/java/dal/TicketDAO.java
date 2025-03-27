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
import model.TicketType;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext {

    public Ticket getByFlightId(String flightID) {
        OrderPassengerDAO opd = new OrderPassengerDAO();
        SeatDAO sd = new SeatDAO();
        FlightDAO fd = new FlightDAO();
        CompartmentDAO cd = new CompartmentDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE flightID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, flightID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
                        fd.getFlightById(rs.getString("flightID")),
                        cd.get(rs.getString("comID")),
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
        CompartmentDAO cd = new CompartmentDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE orderID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, orderID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
                        fd.getFlightById(rs.getString("flightID")),
                        cd.get(rs.getString("comID")),
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
        CompartmentDAO cd = new CompartmentDAO();
        String sql = "SELECT * FROM swp301.ticket WHERE seatID = ? ORDER BY price ASC LIMIT 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, seatID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
                        fd.getFlightById(rs.getString("flightID")),
                        cd.get(rs.getString("comID")),
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
        CompartmentDAO cd = new CompartmentDAO();
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Ticket(
                        rs.getString("id"),
                        opd.get(rs.getString("orderPID")),
                        fd.getFlightById(rs.getString("flightID")),
                        cd.get(rs.getString("comID")),
                        sd.get(rs.getString("seatID")),
                        rs.getString("status")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDAO.class.getName()).log(Level.SEVERE, null, ex);
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

    public List<Ticket> getTicketsByOrderPassengerId(String orderPassengerId) {
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
                + "    o.type, \n"
                + "    tt.type AS ticketType,  -- Thêm trường này để gán vào TicketType\n"
                + "    tt.description, \n"
                + "    tt.percent, \n"
                + "    tt.checkedweightneed, \n"
                + "    tt.handedweightneed, \n"
                + "    f.id AS flightId, \n"
                + "    f.name AS flightName, \n"
                + "    f.code, \n"
                + "    f.airplaneID, \n"
                + "    f.price,  -- Thêm cột price từ bảng Flight\n"
                + "    a.name AS airplaneName,  -- Lấy tên máy bay từ bảng Airplane\n"
                + "    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID\n"
                + "    des.name AS destination, -- Lấy tên địa điểm thay vì ID\n"
                + "    f.entryTime, \n"
                + "    f.startingTime, \n"
                + "    f.landingTime, \n"
                + "    s.id AS seatId, \n"
                + "    s.status AS seatStatus, \n"
                + "    s.reason \n"
                + "FROM Ticket t \n"
                + "JOIN OrderPassenger op ON t.orderPID = op.id  -- Thay orderID bằng orderPID để lấy theo OrderPassenger\n"
                + "JOIN `Order` o ON op.orderID = o.id \n"
                + "JOIN TicketType tt ON o.type = tt.type \n"
                + "JOIN Flight f ON t.flightID = f.id \n"
                + "JOIN Seat s ON t.seatID = s.id \n"
                + "JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên\n"
                + "JOIN Location des ON f.destination = des.id -- Thay ID bằng tên\n"
                + "JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay\n"
                + "WHERE op.id = ?;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderPassengerId);
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
                    flight.setPrice(rs.getInt("price")); // Gán giá vé từ bảng Flight
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

                    TicketType ticketType = new TicketType();
                    ticketType.setType(rs.getString("ticketType"));
                    ticketType.setDescription(rs.getString("description"));
                    ticketType.setCheckedweightneed(rs.getDouble("checkedweightneed"));
                    ticketType.setHandedweightneed(rs.getDouble("handedweightneed"));

                    Order order = new Order();
                    order.setId(rs.getString("orderId"));
                    order.setStatus(rs.getString("orderStatus"));
                    order.setTime(rs.getTimestamp("time").toLocalDateTime());
                    order.setFinalPrice(rs.getDouble("finalPrice"));
                    order.setFinalNum(rs.getInt("finalNum"));
                    order.setTt(ticketType);

                    OrderPassenger orderPassenger = new OrderPassenger();
                    orderPassenger.setOrder(order);
                  

                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("ticketId"));
                    ticket.setOrderP(orderPassenger);
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

    public List<Ticket> getTicketsByPassengerId(String passengerId) {
        String sql = "SELECT t.*, op.id AS orderPassengerID FROM Ticket t "
                + "JOIN OrderPassenger op ON t.orderPID = op.id "
                + "WHERE t.orderPID = ?";
        List<Ticket> tickets = new ArrayList<>();

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, passengerId);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Ticket ticket = new Ticket();
                    ticket.setId(rs.getString("id"));

                    Nation nation = new Nation();

                    // Gán orderPassenger
                    OrderPassenger orderPassenger = new OrderPassenger();
                    orderPassenger.setId(rs.getString("orderPassengerID"));
                    orderPassenger.setNation(nation);
                    ticket.setOrderP(orderPassenger);

                    // Gán flight
                    Flight flight = new Flight();
                    flight.setId(rs.getString("flightID"));
                    ticket.setFlight(flight);

                    // Gán seat
                    Seat seat = new Seat();
                    seat.setId(rs.getString("seatID"));
                    ticket.setSeat(seat);

                    // Gán status
                    ticket.setStatus(rs.getString("status"));

                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching tickets: " + e.getMessage());
        }

        return tickets;
    }

    public List<Ticket> getCancelledOrProcessingTickets() {
        String sql = "SELECT t.id, t.status, t.orderPID, t.flightID, t.comID, t.seatID, "
                + "o.id AS orderPassengerID, "
                + "f.id AS flightID, "
                + "c.id AS compartmentID, "
                + "s.id AS seatID "
                + "FROM Ticket t "
                + "LEFT JOIN OrderPassenger o ON t.orderPID = o.id "
                + "LEFT JOIN Flight f ON t.flightID = f.id "
                + "LEFT JOIN Compartment c ON t.comID = c.id "
                + "LEFT JOIN Seat s ON t.seatID = s.id "
                + "WHERE t.status = 'Cancelled' OR t.status = 'Processing'";

        List<Ticket> tickets = new ArrayList<>();

        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setId(rs.getString("id"));
                ticket.setStatus(rs.getString("status"));

                // Lấy thông tin OrderPassenger
                OrderPassenger orderPassenger = new OrderPassenger();
                orderPassenger.setId(rs.getString("orderPassengerID"));
                ticket.setOrderP(orderPassenger);

                // Lấy thông tin Flight
                Flight flight = new Flight();
                flight.setId(rs.getString("flightID"));
                ticket.setFlight(flight);

                // Lấy thông tin Compartment
                Compartment compartment = new Compartment();
                compartment.setId(rs.getString("compartmentID"));
                ticket.setCompartment(compartment);

                // Lấy thông tin Seat
                Seat seat = new Seat();
                seat.setId(rs.getString("seatID"));
                ticket.setSeat(seat);

                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching cancelled or processing tickets: " + e.getMessage());
        }

        return tickets;
    }

    public int updateTicketStatusByOrderPID(String orderPID, String newStatus) {
        String sql = "UPDATE Ticket SET status = ? WHERE orderPID = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, newStatus);
            stm.setString(2, orderPID);

            return stm.executeUpdate(); // Trả về số dòng được cập nhật
        } catch (SQLException e) {
            System.out.println("Error updating ticket status: " + e.getMessage());
            return 0; // Trả về 0 nếu có lỗi xảy ra
        }
    }

}
