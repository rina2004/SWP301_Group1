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
import model.Flight;
/**
 *
 * @author A A
 */
public class AirplaneDAO extends DBContext{
    public List<Airplane> getAllAirplane() {
        List<Airplane> list = new ArrayList<>();
        String sql = "SELECT id, name, statusID FROM swp301.airplane";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while(rs.next()) {
                list.add(new Airplane(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("statusID")));
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
        return list;
    }
    
    // Phương thức lấy danh sách máy bay được phân công cho một chuyến bay
    public List<Airplane> getAirplanesByFlightId(String flightId) {
        List<Airplane> list = new ArrayList<>();
        String sql = """
            SELECT a.* 
            FROM Airplane a 
            INNER JOIN Flight f ON a.id = f.airplaneId 
            WHERE f.id = ?
        """;
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, flightId);
            ResultSet rs = stm.executeQuery();
            
            while(rs.next()) {
                list.add(new Airplane(rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("statusID")));
            }
            
            rs.close();
            connection.close();
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
        return list;
    }
}
