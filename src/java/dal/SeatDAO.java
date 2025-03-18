/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Compartment;
import model.Seat;
import model.Type;

/**
 *
 * @author tungn
 */
public class SeatDAO extends DBContext {

    public Seat getSeatByID(String seatID) {
        Seat seat = null;
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT s.id, c.id AS compartmentID, c.name AS compartmentName, s.status, c.typeID "
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
                Type type = new Type(rs.getString("typeID"));

                // Tạo Compartment object
                Compartment compartment = new Compartment(compartmentID, compartmentName, type, 0);

                // Tạo Seat object
                seat = new Seat(seatID, compartment, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seat;
    }


    public int getCompartmentCapacity(String compartmentID, String typeID) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT capacity FROM Compartment WHERE id = ? AND typeID = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, compartmentID);
            stm.setString(2, typeID);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("capacity");
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public boolean checkSeatIDExisted(String seatID, char compartmentID, String typeID) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "SELECT COUNT(*) FROM Seat s "
                + "JOIN Compartment c ON s.compartmentid = c.id "
                + "WHERE s.id = ? AND c.id = ? AND c.typeid = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, seatID);
            stm.setString(2, String.valueOf(compartmentID));
            stm.setString(3, typeID);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean validateSeatID(String seatID, char compartmentID) {
        String pattern = compartmentID + "\\d{3}";
        return seatID.matches(pattern);
    }

    public static void main(String[] args) {
        SeatDAO dao = new SeatDAO();
        dao.checkSeatIDExisted("F001", 'F', "A110");

    }

    public ArrayList<Seat> showAllSeatByTypeID(String typeID) {
        ArrayList<Seat> seats = new ArrayList<>();
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT s.id, c.id AS compartmentID, c.name AS compartmentName, s.status, c.typeID "
                + "FROM Seat s "
                + "JOIN Compartment c ON c.id = s.compartmentID "
                + "WHERE c.typeID = ? "
                + "ORDER BY SUBSTRING_INDEX(SUBSTRING_INDEX(s.id, '_', -2), '_', 1), "
                + "CAST(SUBSTRING_INDEX(s.id, '_', -1) AS UNSIGNED)";  // FIX hoàn toàn sắp xếp
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, typeID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String seatID = rs.getString("id");
                String compartmentID = rs.getString("compartmentID");
                String compartmentName = rs.getString("compartmentName");
                String status = rs.getString("status");
                Type type = new Type(rs.getString("typeID"));

                // Tạo Compartment object
                Compartment compartment = new Compartment(compartmentID, compartmentName, type, 0);

                // Thêm ghế vào danh sách
                seats.add(new Seat(seatID, compartment, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }
}
