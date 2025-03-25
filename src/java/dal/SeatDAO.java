/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Seat;

/**
 *
 * @author A A
 */
public class SeatDAO extends DBContext{
    public Seat get(String id) {
        CompartmentDAO cd = new CompartmentDAO();
        String sql = "SELECT * FROM swp301.seat WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Seat(rs.getString("id"),
                        cd.get(rs.getString("compartmentID")),
                        rs.getString("status"),
                        rs.getString("reason"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
