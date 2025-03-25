/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Compartment;

/**
 *
 * @author tungn
 */
public class CompartmentDAO extends DBContext {

    public void createCompartmentandSeat(String airplaneID, Map<String, Integer> compartmentData) {
        String sqlUpdate = "UPDATE Airplane SET numberOfCompartments = ? WHERE id = ?";
        String insertCom = "INSERT INTO Compartment (id, name, airplaneID, capacity) VALUES (?, ?, ?, ?)";
        String insertSeat = "INSERT INTO Seat (id, compartmentid, status) VALUES (?, ?, ?)";

        try {
            PreparedStatement stmUpdate = connection.prepareStatement(sqlUpdate);
            PreparedStatement stmInsertCom = connection.prepareStatement(insertCom);
            PreparedStatement stmInsertSeat = connection.prepareStatement(insertSeat);

            // Cập nhật số khoang vào bảng Airplane
            stmUpdate.setInt(1, 3);
            stmUpdate.setString(2, airplaneID);
            stmUpdate.executeUpdate();

            for (Map.Entry<String, Integer> entry : compartmentData.entrySet()) {
                String type = entry.getKey();  // "B", "F", "E"
                int capacity = entry.getValue();

                // ID khoang: A002-B1, A002-F1, A002-E1
                String idCompartment = airplaneID + "-" + type + "1";

                // Thêm khoang
                stmInsertCom.setString(1, idCompartment);
                stmInsertCom.setString(2, type);  // "B", "F", "E"
                stmInsertCom.setString(3, airplaneID);
                stmInsertCom.setInt(4, capacity);
                stmInsertCom.executeUpdate();

                // Thêm ghế vào khoang
                for (int j = 1; j <= capacity; j++) {
                    String idSeat = idCompartment + "-" + j;  

                    stmInsertSeat.setString(1, idSeat);
                    stmInsertSeat.setString(2, idCompartment);
                    stmInsertSeat.setString(3, "Available");
                    stmInsertSeat.executeUpdate();
                }
            }

            // Đóng kết nối
            stmUpdate.close();
            stmInsertCom.close();
            stmInsertSeat.close();

        } catch (SQLException e) {
            System.out.println("❌ Lỗi: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        CompartmentDAO dao = new CompartmentDAO();
        Map<String, Integer> compartmentData = new HashMap<>();
        compartmentData.put("VIP", 10);       // Khoang VIP có 10 ghế
        compartmentData.put("Business", 20);  // Khoang Business có 20 ghế
        compartmentData.put("Economy", 50);   // Khoang Economy có 50 ghế

        

    }
}
