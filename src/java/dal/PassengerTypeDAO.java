/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import model.*;
import java.util.logging.*;
/**
 *
 * @author A A
 */
public class PassengerTypeDAO extends DBContext{
    public PassengerType get(String id) {
        String sql = "SELECT * FROM swp301.passengertype WHERE id=?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new PassengerType(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getInt("ageMin"),
                        rs.getInt("ageMax"),
                        rs.getDouble("discount"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PassengerTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
