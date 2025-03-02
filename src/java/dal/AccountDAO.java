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

}
