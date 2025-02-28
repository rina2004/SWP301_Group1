/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author anhbu
 */
public class Account {
    private String id;
    private String username;
    private String password;
    private boolean status;
    private int entityID; 
    private int roleID; // Chỉ giữ một vai trò duy nhất

    public Account() {
    }

    public Account(String id, String username, String password, boolean status, int entityID, int roleID) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.status = status;
        this.entityID = entityID;
        this.roleID = roleID;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getEntityID() {
        return entityID;
    }

    public void setEntityID(int entityID) {
        this.entityID = entityID;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    @Override
    public String toString() {
        return "Account{"
                + "id='" + id + '\''
                + ", username='" + username + '\''
                + ", password='" + password + '\''
                + ", status=" + status
                + ", entityID=" + entityID
                + ", roleID=" + roleID
                + '}';
    }
    
    
}
