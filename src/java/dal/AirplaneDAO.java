/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Airplane;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneDAO extends DBContext{
    
    public void insert(Airplane airplane){
        String sql = "INSERT INTO Airplane (id, name, statusID, maintainanceTime, usedTime) "
                       + "VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, airplane.getId());
            stm.setString(2, airplane.getName());
            stm.setInt(3, airplane.getStatus().getId());
            stm.setTimestamp(4, Timestamp.valueOf(airplane.getMaintainanceTime()));
            stm.setTimestamp(5, Timestamp.valueOf(airplane.getUsedTime()));
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    public Airplane get(String id) {
        Airplane airplane = null;
        String sql = "SELECT * FROM swp301.airplane WHERE id = ?";
        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        AirTrafficControlDBContext airtc = new AirTrafficControlDBContext();
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                airplane = new Airplane();
                airplane.setId(rs.getString("id"));
                airplane.setName(rs.getString("name"));
                airplane.setStatus(as.get(rs.getInt("statusID")));
                airplane.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                airplane.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return airplane;
    }
    
    public void update(Airplane airplane) throws Exception{
        String sql = "UPDATE Airplane SET statusID = ?, maintainanceTime = ? WHERE id = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, airplane.getStatus().getId());
            stm.setTimestamp(2, Timestamp.valueOf(airplane.getMaintainanceTime()));
            stm.setString(3, airplane.getId());
            
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error updating airplane: " + ex.getMessage());
        }
    }

    public ArrayList<Airplane> list(){
        ArrayList<Airplane> planes = new ArrayList<>();
        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        String sql = "SELECT * FROM Airplane";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Airplane p = new Airplane();
                p.setId(rs.getString("id"));
                p.setName(rs.getString("name"));
                p.setStatus(as.get(rs.getInt("statusID")));
                p.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                p.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());
                planes.add(p);
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return planes;
    }
}