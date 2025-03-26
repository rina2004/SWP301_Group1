/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Airplane;
import model.Compartment;
import model.Seat;

/**
 *
 * @author A A
 */
public class SeatDAO extends DBContext {

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

    public void updateSeatStatus(String id, String status, String reason) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Update Seat Set status = ? , maintainreason = ? Where id = ? ";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setString(2, reason);
            stm.setString(3, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Seat getSeatByID(String seatID) {
        Seat seat = null;
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT s.id, c.id AS compartmentID, c.name AS compartmentName, s.status, c.airplaneID , s.maintainreason "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "WHERE s.id = ?";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String compartmentID = rs.getString("compartmentID");
                String compartmentName = rs.getString("compartmentName");
                String status = rs.getString("status");
                String airplaneID = rs.getString("airplaneID");
                Airplane airplane = new Airplane();
                airplane.setId(airplaneID);
                String reason = rs.getString("maintainreason");
                Compartment compartment = new Compartment(compartmentID, compartmentName, airplane, 0);

                seat = new Seat(seatID, compartment, status, reason);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seat;
    }

    public ArrayList<Seat> showAllSeatByTypeID(String airplaneID) {
        ArrayList<Seat> seats = new ArrayList<>();
        String sql = "SELECT s.id, c.id AS compartmentID, c.name AS compartmentName, s.status, c.airplaneID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "WHERE c.airplaneID = ? "
                + "ORDER BY "
                + "  CASE "
                + "    WHEN LEFT(c.name, 1) = 'B' THEN 1 "
                + "    WHEN LEFT(c.name, 1) = 'F' THEN 2 "
                + "    WHEN LEFT(c.name, 1) = 'E' THEN 3 "
                + "    ELSE 4 "
                + "  END, "
                + "  CAST(SUBSTRING_INDEX(s.id, '-', -1) AS UNSIGNED);";
        PreparedStatement stm;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, airplaneID);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    String seatID = rs.getString("id");
                    String compartmentID = rs.getString("compartmentID");
                    String compartmentName = rs.getString("compartmentName");
                    String status = rs.getString("status");
                    airplaneID = rs.getString("airplaneID");

                    Airplane airplane = new Airplane();
                    airplane.setId(airplaneID);

                    Compartment compartment = new Compartment(compartmentID, compartmentName, airplane, 0);
                    seats.add(new Seat(seatID, compartment, status, null));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    public void updateBookedSeat(String seatID) {
        PreparedStatement stm;
        String sql = "Update Seat Set status = 'Booked' where id  = ? ";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    

}
