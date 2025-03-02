/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import model.Account;

/**
 *
 * @author tungn
 */
public class AccountDAO extends DBContext {

    public Account login(String username, String password) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Select * from Account where username = ? and password = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();

            if (rs.next()) {
                Account acc = new Account();
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                String status = (rs.getInt("status") == 1) ? "Active" : "Inactive";
                acc.setStatus(status);

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

        }
        return false;
    }

    public void updatePasswordByEmail(String email, String password) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Update Account SET password = ? where email = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, email);
            stm.executeUpdate();

        } catch (SQLException e) {

        }
    }

    public void register(String username, String password, String name, Date dob, String phone, String address, String email) {
        PreparedStatement accountStmt = null;
        PreparedStatement roleStmt = null;

        String id = createCustomerID();
        if (id == null) {
            System.out.println("Không thể khởi tạo ID");
            return;
        }
        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 1️⃣ Thêm vào bảng Account
            String accountSQL = "INSERT INTO Account (id, username, password, name, dob, phone, address, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            accountStmt = connection.prepareStatement(accountSQL);
            accountStmt.setString(1, id);
            accountStmt.setString(2, username);
            accountStmt.setString(3, password);
            accountStmt.setString(4, name);
            accountStmt.setDate(5, new java.sql.Date(dob.getTime()));
            accountStmt.setString(6, phone);
            accountStmt.setString(7, address);
            accountStmt.setString(8, email);
            accountStmt.executeUpdate();

            String roleSQL = "INSERT INTO AccountUserRole (accountID,entityID,roleID) VALUES (?,?,?)";
            roleStmt = connection.prepareStatement(roleSQL);
            roleStmt.setString(1, id);
            roleStmt.setInt(2, 1);
            roleStmt.setInt(3, 3);
            roleStmt.executeUpdate();

            connection.commit();
            System.out.println("✅ Tạo tài khoản thành công!");

        } catch (SQLException e) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();

        } finally {
            try {
                if (accountStmt != null) {
                    accountStmt.close();
                }
                if (roleStmt != null) {
                    roleStmt.close();
                }
                connection.setAutoCommit(true);
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }

    }

    public static void main(String[] args) {
       
        AccountDAO dao = new AccountDAO();
       Account acc = dao.login("khanhnguyen", "123456");
       
        System.out.println(acc.toString());

    }
}
