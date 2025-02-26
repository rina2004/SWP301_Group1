/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import com.mysql.cj.xdevapi.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Account;

/**
 *
 * @author tungn
 */
public class DAO extends DBContext {

    public Account login(String username, String password) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = " SELECT a.username,a.password,a.status,a.id, r.name FROM Account a JOIN Role r ON a.roleID = r.id WHERE username = ? AND password = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
                password = rs.getString("password");
                String status = rs.getInt("status") == 1 ? "Active" : "Inactive";
                String role = rs.getString("r.name");

                Account acc = new Account(username, password, role, status);
                return acc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

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

    public boolean checkAccountExist(String username) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "Select Count(*) From account where username = ?";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void register(String username, String password) {
        String id = createCustomerID();
        if (id == null) {
            System.out.println("Lỗi khi tạo ID");
            return;
        }

        String sql = "INSERT INTO Account(username, password, status, roleID, id) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, username);
            stm.setString(2, password);
            stm.setInt(3, 1);
            stm.setInt(4, 13);
            stm.setString(5, id);

            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {

        DAO dao = new DAO();

        String username = "testUser3";
        String password = "12345678";

        Account acc = dao.login(username, password);
        if(acc != null){
            System.out.println(acc.toString());
        }
    }
}
