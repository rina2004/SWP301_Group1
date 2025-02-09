/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import com.mysql.cj.jdbc.PreparedStatementWrapper;
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
public class FlightDAO extends DBContext{
    public List<Flight> getAllFlight(){
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
                    rs.getDate("entryTime"),
                    rs.getDate("startingTime"),
                    rs.getDate("landingTime"),
                    rs.getBytes("atcID")
                ));
            }
        } catch (SQLException ex){
            System.out.println(ex);
        } finally{
            try {
                stm.close();
                connection.close();
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
            if(rs.next()) {
                return new Flight(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        rs.getString("airplaneID"),
                        rs.getString("departure"),
                        rs.getString("destination"),
                        rs.getDate("entryTime"),
                        rs.getDate("startingTime"),
                        rs.getDate("landingTime"),
                        rs.getBytes("atcID"));
            }
        } catch (SQLException ex){
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally{
            try {
                stm.close();
                connection.close();
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
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public void updateFlight(Flight flight) throws Exception {
        String sql = "UPDATE Flight SET name=?, code=?, airplaneID=?, departure=?, " +
                      "destination=?, entryTime=?, startingTime=?, landingTime=?, atcID=? WHERE id=?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flight.getName());
            stm.setString(2, flight.getCode());
            stm.setString(3, flight.getAirplaneId());
            stm.setString(4, flight.getDeparture());
            stm.setString(5, flight.getDestination());
            stm.setDate(6, (Date) flight.getEntryTime());
            stm.setDate(7, (Date) flight.getStartingTime());
            stm.setDate(8, (Date) flight.getLandingTime());
            stm.setBytes(9, flight.getAtcId());
            stm.setString(10, flight.getId());
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
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
    public boolean deleteFlight(String id) throws Exception {
    String sql = "DELETE FROM Flight WHERE id=?";
    PreparedStatement stm = null;
    try {
        // Disable foreign key checks temporarily
        connection.setAutoCommit(false);
        Statement checkStmt = connection.createStatement();
        checkStmt.execute("SET FOREIGN_KEY_CHECKS=0");
        
        stm = connection.prepareStatement(sql);
        stm.setString(1, id);
        int rowsAffected = stm.executeUpdate();
        
        // Re-enable foreign key checks
        checkStmt.execute("SET FOREIGN_KEY_CHECKS=1");
        connection.commit();
        
        return rowsAffected > 0;
    } catch (SQLException ex) {
        if (connection != null) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        throw ex;
    } finally {
        if (stm != null) {
            try {
                stm.close();
            } catch (SQLException e) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
        if (connection != null) {
            try {
                connection.setAutoCommit(true);
                connection.close();
            } catch (SQLException e) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, e);
            }
        }
    }
}
}