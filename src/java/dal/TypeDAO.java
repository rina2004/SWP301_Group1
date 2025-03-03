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
public class TypeDAO extends DBContext {

    public Type get(String id) {
        Type type = null;
        String sql = "SELECT * FROM swp301.type WHERE id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
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
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return type;
    }

    public ArrayList<Type> list() {
        ArrayList<Type> types = new ArrayList<>();
        String sql = "SELECT * FROM Type";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Type type = new Type();
                type.setId(rs.getString("id"));
                type.setName(rs.getString("name"));
                type.setManufacture(rs.getString("manufacture"));
                type.setLength(rs.getFloat("length"));
                type.setWeight(rs.getFloat("weight"));
                type.setHeight(rs.getFloat("height"));
                types.add(type);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return types;
    }

    public void insert(Type type) {
        String sql = "INSERT INTO `swp301`.`type`(`id`, `Name`, `manufacture`, `length`, `weight`, `height`) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, type.getId());
            stm.setString(2, type.getName());
            stm.setString(3, type.getManufacture());
            stm.setFloat(4, type.getLength());
            stm.setFloat(5, type.getWeight());
            stm.setFloat(6, type.getHeight());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error inserting airplane type: " + ex.getMessage());
        }
    }

    public void update(Type type) {
        String sql = """
                 UPDATE `swp301`.`type`
                 SET `Name` = ?, `manufacture` = ?, `length` = ?, `weight` = ?, `height` = ?
                 WHERE `id` = ?;""";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, type.getName());
            stm.setString(2, type.getManufacture());
            stm.setFloat(3, type.getLength());
            stm.setFloat(4, type.getWeight());
            stm.setFloat(5, type.getHeight());
            stm.setString(6, type.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error updating airplane type: " + ex.getMessage());
        }
    }

    public void delete(String id) {
        String sql = "DELETE FROM swp301.`type` WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TypeDAO.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Error deleting airplane type: " + ex.getMessage());
        }
    }
}
