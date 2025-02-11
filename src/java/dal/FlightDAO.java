/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;

/**
 *
 * @author A A
 */
public class FlightDAO extends DBContext {

    public List<Flight> getAllFlight() {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.flight";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getString("airplaneID"),
                        rs.getString("departure"),
                        rs.getString("destination"),
                        rs.getTimestamp("entryTime"),
                        rs.getTimestamp("startingTime"),
                        rs.getTimestamp("landingTime"),
                        rs.getBytes("atcID")
                ));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public Flight getFlightById(String id) throws Exception {
        //encoding id
        String sql = "SELECT * FROM Flight WHERE id = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id); //1 la ? thu 1 trong sql statement
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Flight(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getString("airplaneID"),
                        rs.getString("departure"),
                        rs.getString("destination"),
                        rs.getTimestamp("entryTime"),
                        rs.getTimestamp("startingTime"),
                        rs.getTimestamp("landingTime"),
                        rs.getBytes("atcID"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }

    public void insertFlight(Flight flight) throws Exception {
        String sql = "INSERT INTO Flight VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flight.getId());
            stm.setString(2, flight.getName());
            stm.setString(3, flight.getCode());
            stm.setString(4, flight.getAirplaneId());
            stm.setString(5, flight.getDeparture());
            stm.setString(6, flight.getDestination());
            stm.setDate(7, (Date) flight.getEntryTime());
            stm.setDate(8, (Date) flight.getStartingTime());
            stm.setDate(9, (Date) flight.getLandingTime());
            stm.setBytes(10, flight.getAtcId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void createFlight(Flight flight) throws SQLException {
        String sql = "INSERT INTO Flight (id, name, code, airplaneID, departure, destination, "
                + "entryTime, startingTime, landingTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flight.getId());
            stm.setString(2, flight.getName());
            stm.setString(3, flight.getCode());
            stm.setString(4, flight.getAirplaneId());
            stm.setString(5, flight.getDeparture());
            stm.setString(6, flight.getDestination());
            stm.setDate(7, new java.sql.Date(flight.getEntryTime().getTime()));
            stm.setDate(8, new java.sql.Date(flight.getStartingTime().getTime()));
            stm.setDate(9, new java.sql.Date(flight.getLandingTime().getTime()));

            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public void updateFlight(Flight flight) throws Exception {
        String sql = "UPDATE Flight SET departure=?, "
                + "destination=?, entryTime=?, startingTime=?, landingTime=? WHERE id=?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flight.getDeparture());
            stm.setString(2, flight.getDestination());
            stm.setDate(3, (Date) flight.getEntryTime());
            stm.setDate(4, (Date) flight.getStartingTime());
            stm.setDate(5, (Date) flight.getLandingTime());
            stm.setString(6, flight.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public List<Flight> getFlightsByPriceRange(double minPrice, double maxPrice) {
        List<Flight> flights = new ArrayList<>();
        String sql = """
            SELECT f.* FROM Flight f INNER JOIN Ticket t ON f.id = t.flightId 
            WHERE t.price BETWEEN ? AND ?
            ORDER BY t.price ASC""";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setDouble(1, minPrice);
            stm.setDouble(2, maxPrice);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                flights.add(new Flight(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getString("airplaneID"),
                        rs.getString("departure"),
                        rs.getString("destination"),
                        rs.getTimestamp("entryTime"),
                        rs.getTimestamp("startingTime"),
                        rs.getTimestamp("landingTime"),
                        rs.getBytes("atcID")));
            }
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return flights;
    }

    public double getLowestTicketPrice(String flightId) {
        double price = 0;
        String sql = "SELECT MIN(price) as minPrice FROM Ticket WHERE flightId = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flightId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                price = rs.getDouble("minPrice");
            }
            rs.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return price;
    }
}
