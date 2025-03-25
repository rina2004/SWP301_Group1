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
import model.TicketType;

/**
 *
 * @author A A
 */
public class TicketTypeDAO extends DBContext{
    public TicketType get(String id) {
        String sql = "SELECT * FROM swp301.tickettype WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new TicketType(rs.getString("type"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getDouble("checkedweightneed"),
                        rs.getDouble("handedweightneed"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
