/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.AirplaneStatus;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneStatusDBContext extends DBContext<AirplaneStatus> {

    @Override
    public void insert(AirplaneStatus model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void update(AirplaneStatus model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(AirplaneStatus model) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public ArrayList<AirplaneStatus> list() {
        ArrayList<AirplaneStatus> statuses = new ArrayList<>();
        String sql = "SELECT * FROM swp301.airplane_status";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                AirplaneStatus status = new AirplaneStatus();
                status.setId(rs.getInt("id"));
                status.setName(rs.getString("name"));
                statuses.add(status);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneStatusDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return statuses;
    }

    
    public AirplaneStatus get(int id) {
        AirplaneStatus status = null;
        String sql = "SELECT * FROM swp301.airplane_status WHERE id = ?";
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                status = new AirplaneStatus();
                status.setId(rs.getInt("id"));
                status.setName(rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneStatusDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return status;
    }
}
