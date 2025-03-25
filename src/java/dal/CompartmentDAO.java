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
import model.Compartment;

/**
 *
 * @author A A
 */
public class CompartmentDAO extends DBContext{
    public Compartment get(String id) {
        TicketTypeDAO ttd = new TicketTypeDAO();
        AirplaneDAO ad = new AirplaneDAO();
        String sql = "SELECT * FROM swp301.compartment WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Compartment(rs.getString("id"),
                        ttd.get(rs.getString("type")),
                        ad.get(rs.getString("airplaneID")),
                        rs.getInt("capacity"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompartmentDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
