/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.*;
import java.util.logging.*;
import model.*;
/**
 *
 * @author Rinaaaa
 */
public class CompartmentTypeDAO extends DBContext{
    public CompartmentType get(String id) {
        String sql = """
                     SELECT `id`, `name`
                     FROM `CompartmentType`
                     WHERE `id` = ?;
                     """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                CompartmentType compartmentType = new CompartmentType();
                compartmentType.setId(rs.getString("id"));
                compartmentType.setName(rs.getString("name"));
                return compartmentType;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(CompartmentTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public ArrayList<CompartmentType> list() {
        ArrayList<CompartmentType> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.compartmenttype";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new CompartmentType(rs.getString("id"),
                        rs.getString("name")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompartmentTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
