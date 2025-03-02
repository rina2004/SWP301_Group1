/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author anhbu
 */
public class Account {
    private String id;
    private String username;
    private String password;
    private boolean status;
    private String citizenID;
    private String name;
    private Date dob;
    private String phone;
    private String address;
    private String email;
    private int entityID;
    private int roleID;

    public Account() {
    }

    public Account(String id, String username, String password, boolean status, String citizenID, String name, Date dob, String phone, String address, String email, int entityID, int roleID) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.status = status;
        this.citizenID = citizenID;
        this.name = name;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.email = email;
        this.entityID = entityID;
        this.roleID = roleID;
    }

    public Account(String username, String password, String name, String citizenID, java.sql.Date dateDob, String phone, String address, String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
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
    

    public String getCitizenID() {
        return citizenID;
    }

    public void setCitizenID(String citizenID) {
        this.citizenID = citizenID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
        return "Account{" +
                "id='" + id + '\'' +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", status=" + status +
                ", citizenID='" + citizenID + '\'' +
                ", name='" + name + '\'' +
                ", dob='" + dob + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", email='" + email + '\'' +
                ", entityID=" + entityID +
                ", roleID=" + roleID +
                '}';
    }
    
}
