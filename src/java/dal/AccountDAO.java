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
import java.util.UUID;
import model.Account;

/**
 *
 * @author anhbu
 */
public class AccountDAO extends DBContext {

    // Lấy tất cả tài khoản (trừ Admin)
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT a.*, aur.entityID, aur.roleID FROM Account a LEFT JOIN AccountUserRole aur ON a.id = aur.accountID";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Account acc = new Account(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getBoolean("status"),
                        rs.getString("citizenID"),
                        rs.getString("name"),
                        rs.getDate("dob"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getInt("entityID"),
                        rs.getInt("roleID")
                );
                accounts.add(acc);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllAccounts: " + e);
        }
        return accounts;
    }

    // Cập nhật mật khẩu và trạng thái tài khoản
    public void updateAccount(String id, String password, boolean status) {
        String sql = "UPDATE Account SET password = ?, status = ? WHERE id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, password);
            st.setBoolean(2, status);
            st.setString(3, id);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updateAccount: " + e);
        }
    }

    // Lấy tài khoản theo ID (bao gồm role)
    public Account getUserByID(String id) {
        String sql = "SELECT a.*, aur.entityID, aur.roleID FROM Account a LEFT JOIN AccountUserRole aur ON a.id = aur.accountID WHERE a.id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getString("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getBoolean("status"),
                            rs.getString("citizenID"),
                            rs.getString("name"),
                            rs.getDate("dob"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("email"),
                            rs.getInt("entityID"),
                            rs.getInt("roleID")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserByID: " + e);
        }
        return null;
    }

    // Kiểm tra xem username đã tồn tại chưa
    public boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM Account WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println("Error in isUsernameExists: " + e);
        }
        return false;
    }

    // Thêm tài khoản mới và gán vai trò
    public boolean addUser(String username, String password, boolean status, int entityID, int roleID) {
        if (isUsernameExists(username)) {
            System.out.println("Username already exists.");
            return false;
        }

        String generatedID = UUID.randomUUID().toString();

        String accountSql = "INSERT INTO Account (id, username, password, status) VALUES (?, ?, ?, ?)";
        String roleSql = "INSERT INTO AccountUserRole (accountID, entityID, roleID) VALUES (?, ?, ?)";

        try (PreparedStatement accSt = connection.prepareStatement(accountSql)) {
            accSt.setString(1, generatedID);
            accSt.setString(2, username);
            accSt.setString(3, password);
            accSt.setBoolean(4, status);
            int rowsInserted = accSt.executeUpdate();

            if (rowsInserted > 0) {
                try (PreparedStatement roleSt = connection.prepareStatement(roleSql)) {
                    roleSt.setString(1, generatedID);
                    roleSt.setInt(2, entityID);
                    roleSt.setInt(3, roleID);
                    roleSt.executeUpdate();
                }
                return true;
            }
        } catch (SQLException e) {
            System.out.println("Error in addUser: " + e);
        }
        return false;
    }

    public Account getAccountByUsername(String username) {
        String sql = "SELECT a.*, aur.entityID, aur.roleID FROM Account a "
                + "LEFT JOIN AccountUserRole aur ON a.id = aur.accountID "
                + "WHERE a.username = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getString("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getBoolean("status"),
                            rs.getString("citizenID"),
                            rs.getString("name"),
                            rs.getDate("dob"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("email"),
                            rs.getInt("entityID"),
                            rs.getInt("roleID")
                    );
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getAccountByUsername: " + e);
        }
        return null;
    }
    
    

}
