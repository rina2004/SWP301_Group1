/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
/**
 *
 * @author tungn
 */
public class AccountDAO extends DBContext{
    public String createCustomerID() {
        String sqlInsert = "INSERT INTO Customer VALUES ()";
        String sqlSelect = "SELECT id FROM Customer "
                + "ORDER BY CAST(SUBSTRING(id, 2) AS UNSIGNED) DESC "
                + "LIMIT 1;";

        try {
            PreparedStatement stmInsert = connection.prepareStatement(sqlInsert);
            stmInsert.executeUpdate();

            PreparedStatement stmSelect = connection.prepareStatement(sqlSelect);
            ResultSet rs = stmSelect.executeQuery();

            if (rs.next()) {
                return rs.getString("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkUserNameExist(String username) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Select Count(username) From account Where username = ?";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkEmailExist(String email) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Select Count(email) from account where email = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void register(String username, String password, String status, String name, Date dob, String phone, String address, String email) {
        PreparedStatement stm;
        ResultSet rs;

        String id = createCustomerID();
        if (id == null) {
            System.out.println("Không thể khởi tạo ID");
            return;
        }

        String sql = "Insert into Account(id,username,password,status,name,dob,phone,address,email)"
                + "Values(?,?,?,?,?,?,?,?,?)";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            stm.setString(2, username);
            stm.setString(3, password);
            stm.setInt(4, 1);
            stm.setString(5, name);
            stm.setDate(6, dob);
            stm.setString(7, phone);
            stm.setString(8, address);
            stm.setString(9, email);

            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
