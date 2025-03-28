/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
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

    public boolean updateSeats(List<Seat> seats) {
        String query = "UPDATE seat SET status = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query);) {
            

            for (Seat seat : seats) {
                ps.setString(1, seat.getStatus());
                ps.setString(2, seat.getId());
                ps.addBatch();
            }

            int[] results = ps.executeBatch();
            return Arrays.stream(results).allMatch(r -> r > 0);
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public Seat getSeatByID(String seatID) {
        Seat seat = null;
        String sql = "SELECT s.id, c.id AS compartmentID, c.type AS compartmentType, s.status, s.reason, c.airplaneID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "WHERE s.id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, seatID);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    String compartmentID = rs.getString("compartmentID");
                    String status = rs.getString("status");
                    String reason = rs.getString("reason");
                    String airplaneID = rs.getString("airplaneID"); // Lấy airplaneID

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
        String sql = "SELECT s.id, c.id AS compartmentID, c.type AS compartmentType, s.status, c.airplaneID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "WHERE c.airplaneID = ? "
                + "ORDER BY "
                + "  CASE "
                + "    WHEN LEFT(c.type, 1) = 'B' THEN 1 "
                + "    WHEN LEFT(c.type, 1) = 'F' THEN 2 "
                + "    WHEN LEFT(c.type, 1) = 'E' THEN 3 "
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
        String testAirplaneID = "VN-A001";

        List<Seat> list = seatDAO.showAllSeatByTypeID(testAirplaneID);
        for (Seat seat : list) {
            System.out.println(seat.toString());
        }
    }

}
