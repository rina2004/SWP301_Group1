/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Account;

/**
 *
 * @author anhbu
 */
public class AccountDAO extends DBContext {

    // Get all accounts
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String sql = "SELECT * FROM Account WHERE RoleID <> 1";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Account acc = new Account(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getBoolean("status")
                );
                accounts.add(acc);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return accounts;
    }

    // Update account information
    public void updateAccount(String id, String password, boolean status) {
        String sql = "UPDATE Account SET password = ?, status = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setBoolean(2, status);
            st.setString(3, id);

            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Get user by ID
    public Account getUserByID(String id) {
        String sql = "SELECT * FROM Account WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, id);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getInt("roleID"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public boolean isUsernameExists(String username) {
        String sql = "SELECT 1 FROM Account WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error in isUsernameExists: " + e);
        }
        return false;
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
    
    public boolean checkPassword(String username,String password){
        PreparedStatement stm;
        ResultSet rs;
        String sql = "Select Count(password) where username = ? and password = ?";
        
        try{
          stm = connection.prepareStatement(sql);
          stm.setString(1, username);
          stm.setString(2, password);
          rs = stm.executeQuery();
          if(rs.next() && rs.getInt(1) > 0){
              return true;
          }
        }catch(SQLException e){
            
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

}
