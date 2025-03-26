/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;
import model.*;

/**
 *
 * @author A A
 */
public class NationDAO extends DBContext{
    public ArrayList<Nation> list(){
        ArrayList<Nation> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.nation";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Nation(
                        rs.getInt("id"),
                        rs.getString("name")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(NationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
