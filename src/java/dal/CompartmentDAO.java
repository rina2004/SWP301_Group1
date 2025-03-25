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
import model.Airplane;
import model.Compartment;

/**
 *
 * @author tungn
 */
public class CompartmentDAO extends DBContext {

    public void createCompartmentandSeat(Airplane airplane, Map<String, Integer> compartmentData) {
        String updateAir = "UPDATE Airplane SET numOfComs = ? WHERE id = ?";
        String insertCom = "INSERT INTO Compartment (id, name, airplaneID, capacity) VALUES (?, ?, ?, ?)";
        String insertSeat = "INSERT INTO Seat (id, compartmentid, status) VALUES (?, ?, ?)";

        try {
            PreparedStatement stmUpdate = connection.prepareStatement(updateAir);
            PreparedStatement stmInsertCom = connection.prepareStatement(insertCom);
            PreparedStatement stmInsertSeat = connection.prepareStatement(insertSeat);

            // Cập nhật số khoang vào bảng Airplane
            stmUpdate.setInt(1, airplane.getNumOfComs());
            stmUpdate.setString(2, airplane.getId());
            stmUpdate.executeUpdate();

            for (Map.Entry<String, Integer> entry : compartmentData.entrySet()) {
                String type = entry.getKey();  // "B", "F", "E"
                int capacity = entry.getValue();

                // ID khoang: A002-B1, A002-F1, A002-E1
                String compartmentID = airplane.getId() + "-" + type + "1";

                // Thêm khoang
                stmInsertCom.setString(1, compartmentID);
                stmInsertCom.setString(2, type);  // "B", "F", "E"
                stmInsertCom.setString(3, airplane.getId());
                stmInsertCom.setInt(4, capacity);
                stmInsertCom.executeUpdate();

                // Thêm ghế vào khoang
                for (int j = 1; j <= capacity; j++) {
                    String idSeat = compartmentID + "-" + j;  

                    stmInsertSeat.setString(1, idSeat);
                    stmInsertSeat.setString(2, compartmentID);
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
}
