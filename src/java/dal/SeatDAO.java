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
import model.Seat;
import model.TicketType;

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

        String sql = "Update Seat Set status = ? , reason = ? Where id = ? ";
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
        String sql = "SELECT s.id, c.id AS compartmentID, ct.id AS compartmentType, s.status, s.reason, c.airplaneID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "JOIN CompartmentType ct ON c.typeId = ct.id "
                + "WHERE s.id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, seatID);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    String compartmentID = rs.getString("compartmentID");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");
                    String airplaneID = rs.getString("airplaneID");

                    Airplane airplane = new Airplane();
                    airplane.setId(airplaneID);

                    Compartment compartment = new Compartment();
                    compartment.setAirplane(airplane);
                    compartment.setId(compartmentID);
                    seat = new Seat(seatID, compartment, status, reason);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seat;
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

    public ArrayList<Seat> showAllSeatByTypeID(String airplaneID) {
        ArrayList<Seat> seats = new ArrayList<>();
        String sql = "SELECT s.id, c.id AS compartmentID, s.status, c.airplaneID, ct.id AS typeID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "JOIN CompartmentType ct ON c.typeId = ct.id "
                + "WHERE c.airplaneID = ? "
                + "ORDER BY "
                + "  CASE "
                + "    WHEN LEFT(ct.id, 1) = 'B' THEN 1 "
                + "    WHEN LEFT(ct.id, 1) = 'F' THEN 2 "
                + "    WHEN LEFT(ct.id, 1) = 'E' THEN 3 "
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
                    String status = rs.getString("status");
                    String airplaneIDFromDB = rs.getString("airplaneID");

                    Airplane airplane = new Airplane();
                    airplane.setId(airplaneIDFromDB);

                    Compartment compartment = new Compartment();
                    compartment.setAirplane(airplane);

                    seats.add(new Seat(seatID, compartment, status, null));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    public static void main(String[] args) {
        SeatDAO seatDAO = new SeatDAO();
        String testAirplaneID = "VN-A001-B-1";

       Seat s = seatDAO.getSeatByID(testAirplaneID);
        System.out.println(s.toString());
    }

}
