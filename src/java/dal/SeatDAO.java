/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Account;
import model.Airplane;
import model.Compartment;
import model.Order;
import model.Seat;
import model.Ticket;


/**
 *
 * @author tungn
 */
public class SeatDAO extends DBContext {

    public void updateSeatStatus(String id, String status) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Update Seat Set status = ? Where id = ? ";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, status);
            stm.setString(2, id);
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

//                Compartment compartment = new Compartment(compartmentID, compartmentName, airplane, 0);
//
//                seat = new Seat(seatID, compartment, status, reason);
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

                 //   Compartment compartment = new Compartment(compartmentID, compartmentName, airplane, 0);
                 //   seats.add(new Seat(seatID, compartment, status, null));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
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

    public Seat getInformation(String seatID) {
        String sql = "Select * From Seat where id = ?";
        PreparedStatement stm;
        ResultSet rs;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            rs = stm.executeQuery();

            if (rs.next()) {
                Seat seat = new Seat();
                seat.setId(rs.getString("id"));        
                seat.setStatus(rs.getString("status"));

                return seat;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        SeatDAO dao = new SeatDAO();
        String id = "VN-A001-1";
        Seat seat = dao.getInformation(id);

        System.out.println(seat.toString());

    }
}
