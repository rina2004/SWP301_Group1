/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;
import java.util.UUID;
import model.Account;
import model.Role;

/**
 *
 * @author anhbu
 */
public class AccountDAO extends DBContext {

    // Lấy tất cả tài khoản (trừ Admin)
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT a.*, r.name AS roleName FROM Account a JOIN Role r ON a.roleID = r.id WHERE a.roleID != 1"; // Loại bỏ Admin

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Role role = new Role(rs.getInt("roleID"), rs.getString("roleName")); // Sửa "roleName"
                Account acc = new Account(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        role, // Truyền vào đối tượng Role
                        rs.getBoolean("status"),
                        rs.getString("citizenID"),
                        rs.getString("name"),
                        rs.getDate("dob"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("email")
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
        String sql = "SELECT a.*, r.name AS roleName FROM Account a JOIN Role r ON a.roleID = r.id WHERE a.id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("roleID"), rs.getString("roleName")); // Sửa "roleName"
                    return new Account(
                            rs.getString("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            role,
                            rs.getBoolean("status"),
                            rs.getString("citizenID"),
                            rs.getString("name"),
                            rs.getDate("dob"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("email")
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
    public boolean addUser(String username, String password, Role role, boolean status, String citizenID, String name, Date dob, String phone, String address, String email) {
        if (isUsernameExists(username)) {
            System.out.println("Username already exists.");
            return false;
        }

        String generatedID = UUID.randomUUID().toString();
        String sql = "INSERT INTO Account (id, username, password, roleID, status, citizenID, name, dob, phone, address, email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, generatedID);
            st.setString(2, username);
            st.setString(3, password);
            st.setInt(4, role.getId()); // Lấy roleID từ Role
            st.setBoolean(5, status);
            st.setString(6, citizenID);
            st.setString(7, name);
            st.setDate(8, dob);
            st.setString(9, phone);
            st.setString(10, address);
            st.setString(11, email);

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("Error in addUser: " + e);
        }
        return false;
    }

    public Account getAccountByUsername(String username) {
        String sql = "SELECT a.*, r.id AS roleID, r.name AS roleName FROM Account a JOIN Role r ON a.roleID = r.id WHERE a.username = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Role role = new Role(rs.getInt("roleID"), rs.getString("roleName"));
                    return new Account(
                            rs.getString("id"),
                            rs.getString("username"),
                            rs.getString("password"),
                            role,
                            rs.getBoolean("status"),
                            rs.getString("citizenID"),
                            rs.getString("name"),
                            rs.getDate("dob"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getString("email")
                    );
                } else {
                    System.out.println("No account found for username: " + username);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getAccountByUsername: " + e.getMessage());
        }
        return null;
    }

    public void updateProfile(Account acc) {
        String sql = "UPDATE Account SET name=?, citizenID=?, dob=?, phone=?, address=?, email=? WHERE id=?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            // Chuyển đổi dob sang java.sql.Date
            Date sqlDob = (acc.getDob() != null) ? new Date(acc.getDob().getTime()) : null;

            // Gán giá trị vào PreparedStatement (bỏ mật khẩu)
            stm.setString(1, acc.getName());
            stm.setString(2, acc.getCitizenID());
            stm.setDate(3, sqlDob);
            stm.setString(4, acc.getPhone());
            stm.setString(5, acc.getAddress());
            stm.setString(6, acc.getEmail());
            stm.setString(7, acc.getId()); // Cập nhật theo ID tài khoản

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected == 0) {
                System.out.println("No account was updated. Check the userID.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updateAccountDetails(String accountId, String email, String phone) {
        String sql = "UPDATE Account SET email = ?, phone = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, phone);
            st.setString(3, accountId);

            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean addUser(String username, String password, int roleID, boolean status) {
        if (isUsernameExists(username)) {
            System.out.println("Username already exists.");
            return false;
        }

        String sql = "INSERT INTO Account (username, password, roleID, status) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, roleID);
            st.setBoolean(4, status);

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("Error in addUser: " + e);
        }
        return false;
    }

    public Account login(String username, String password) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "SELECT a.*, r.id as roleId, r.name as roleName FROM Account a "
                + "JOIN Role r ON a.roleID = r.id "
                + "WHERE a.username = ? AND a.password = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next()) {
                boolean status = rs.getBoolean("status");
                if (!status) {
                    return null;
                }
                Account acc = new Account();
                acc.setId(rs.getString("id"));
                acc.setUsername(rs.getString("username"));
                acc.setPassword(rs.getString("password"));
                acc.setStatus(status);
                
                Role role = new Role();
                role.setId(rs.getInt("roleId"));
                role.setName(rs.getString("roleName"));
                acc.setRole(role);
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

    public boolean checkPhoneExist(String phone) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "SELECT COUNT(phone) FROM account WHERE phone = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, phone);
            rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Nếu số lượng > 0, nghĩa là phone đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePasswordByUsername(String username, String password) {
        PreparedStatement stm;
        ResultSet rs;

        String sql = "Update Account Set password = ? where username = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, password);
            stm.setString(2, username);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public boolean checkPassword(String username, String password) {
        PreparedStatement stm;
        ResultSet rs;
        String sql = "Select Count(password) where username = ? and password = ?";

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
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

    public void updatePasswordProfile(String username, String newPassword) {
        PreparedStatement stm;
        String sql = "UPDATE Account SET password = ? WHERE username = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, newPassword); // Nên dùng hashing nếu bảo mật cao hơn
            stm.setString(2, username);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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

}
