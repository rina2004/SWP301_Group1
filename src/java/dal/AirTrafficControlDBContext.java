/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AirTrafficControl;

/**
 *
 * @author Rinaaaa
 */
public class AirTrafficControlDBContext extends DBContext {
    public ArrayList<AirTrafficControl> list() {
        ArrayList<AirTrafficControl> atcs = new ArrayList<>();
        try {
            String sql = "SELECT id, name FROM AirTrafficControl";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AirTrafficControl atc = new AirTrafficControl();
                atc.setId(rs.getString("id"));
                atc.setName(rs.getString("name"));
                atcs.add(atc);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return atcs;
    }
    
     public AirTrafficControl get(String id) {
        AirTrafficControl atc = null;
        String sql = "SELECT * FROM swp301.airtrafficcontrol WHERE id = ?";
        PreparedStatement stm = null;
        
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                atc = new AirTrafficControl();
                atc.setId(rs.getString("id"));
                atc.setName(rs.getString("name"));
                atc.setCreatedDate(rs.getTimestamp("createdDate").toLocalDateTime());
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirTrafficControlDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return atc;
    }
}
