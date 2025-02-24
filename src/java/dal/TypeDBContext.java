/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Type;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rinaaaa
 */
public class TypeDBContext extends DBContext{
    public Type get(String id) {
        Type type = null;
        String sql = "SELECT * FROM swp301.type WHERE id = ?";
        PreparedStatement stm = null;
        
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                type = new Type();
                type.setId(rs.getString("id"));
                type.setName(rs.getString("name"));
                type.setManufacture(rs.getString("manufacture"));
                type.setLength(rs.getFloat("length"));
                type.setWeight(rs.getFloat("weight"));
                type.setHeight(rs.getFloat("height"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TypeDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return type;   
    }
}