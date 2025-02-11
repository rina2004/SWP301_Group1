/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class TicketDAO extends DBContext{
    public List<Ticket> getAllTicket() throws SQLException{
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.ticket";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Ticket(rs.getString("id"),
                        rs.getString("flightID"),
                        rs.getString("type"),
                        rs.getInt("Price"),
                        rs.getString("Status")));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        } finally {
            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }
    public Ticket getTicketById(String id) throws Exception{
        String sql = "SELECT * FROM swp301.ticket where id=?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id); 
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Ticket(rs.getString("id"),
                        rs.getString("flightID"),
                        rs.getString("type"),
                        rs.getInt("Price"),
                        rs.getString("Status"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return null;
    }
}
