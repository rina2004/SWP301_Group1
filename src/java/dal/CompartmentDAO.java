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
import model.Airplane;
import model.Compartment;
import model.TicketType;

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
    public ArrayList<Compartment> getCompartmentsByFlightId(String flightId) {
        ArrayList<Compartment> compartments = new ArrayList<>();
        String sql = """
            SELECT c.id, c.type, tt.price, c.airplaneID
            FROM Flight f
            JOIN Airplane a ON f.airplaneID = a.id
            JOIN Compartment c ON a.id = c.airplaneID
            JOIN TicketType tt ON c.type = tt.type
            WHERE f.id = ?;
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, flightId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TicketType ticketType = new TicketType();
                ticketType.setType(rs.getString("type"));
                ticketType.setPrice(rs.getDouble("price"));
                Airplane airplane = new Airplane();
                airplane.setId(rs.getString("airplaneID"));
                Compartment compartment = new Compartment();
                compartment.setId(rs.getString("id"));
                compartment.setType(ticketType);
                compartment.setAirplane(airplane);
                compartments.add(compartment);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return compartments;
    }
}
