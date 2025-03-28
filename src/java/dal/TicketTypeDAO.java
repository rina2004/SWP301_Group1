/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.*;
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
                        rs.getDouble("percent"),
                        rs.getDouble("checkedweightneed"),
                        rs.getDouble("handedweightneed"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public ArrayList<TicketType> list() {
        ArrayList<TicketType> list = new ArrayList<>();
        String sql = "SELECT * FROM TicketType";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new TicketType(
                    rs.getString("type"),
                    rs.getString("description"),
                    rs.getDouble("percent"),
                    rs.getDouble("checkedweightneed"),
                    rs.getDouble("handedweightneed")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
