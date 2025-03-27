/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */  
package dal;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Location;
/**
 *
 * @author A A
 */
public class LocationDAO extends DBContext {
    public ArrayList<Location> list() {
        ArrayList<Location> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.location";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Location(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public Location getById(int id) {
        String sql = "SELECT * FROM swp301.location WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)){
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Location(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public Location getByName(String name) {
        String sql = "SELECT * FROM swp301.location WHERE name = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Location(
                        rs.getInt("id"),
                        rs.getString("name")
                );
            }
        } catch (SQLException ex) {
            Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public ArrayList<Location> searchByName(String keyword) {
        ArrayList<Location> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.location WHERE name LIKE ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Location(
                        rs.getInt("id"),
                        rs.getString("name")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(LocationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
