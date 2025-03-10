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
    
    public void insert(Airplane airplane) {
        String sql = "INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime, atcID) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, airplane.getId());
            stm.setString(2, airplane.getName());
            stm.setString(3, airplane.getType().getId());
            stm.setInt(4, airplane.getStatus().getId());
            stm.setTimestamp(5, Timestamp.valueOf(airplane.getMaintainanceTime()));
            stm.setTimestamp(6, Timestamp.valueOf(airplane.getUsedTime()));
            stm.setString(7, airplane.getAtc().getId());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error inserting airplane: " + ex.getMessage());
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
        
        TypeDAO tp = new TypeDAO();
        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        AirTrafficControlDBContext airtc = new AirTrafficControlDBContext();
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                airplane = new Airplane();
                airplane.setId(rs.getString("id"));
                airplane.setName(rs.getString("name"));
                airplane.setType(tp.get(rs.getString("typeID")));
                airplane.setStatus(as.get(rs.getInt("statusID")));
                airplane.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                airplane.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());
                airplane.setAtc(airtc.get(rs.getString("atcID")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return airplane;
    }
    
    public void update(Airplane airplane) {
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

    public ArrayList<Airplane> list() {
        ArrayList<Airplane> planes = new ArrayList<>();
        TypeDAO tp = new TypeDAO();
        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        AirTrafficControlDBContext airtc = new AirTrafficControlDBContext();
        String sql = "SELECT * FROM swp301.airplane";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Airplane p = new Airplane();
                p.setId(rs.getString("id"));
                p.setName(rs.getString("name"));
                p.setType(tp.get(rs.getString("typeID")));
                p.setStatus(as.get(rs.getInt("statusID")));
                p.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                p.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());
                p.setAtc(airtc.get(rs.getString("atcID")));
                planes.add(p);
            }
        }
        catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return planes;
    }
}