/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author tungn
 */
public class Account {
    private String username;
    private String password;
    private String role;
    private String status;
    private String id;
    private String citizenID;
    private String name;
    private Date dob;
    private String phone;
    private String address;
    private String email;
    private String adminID;

    public Account() {
    }

    public Account(String username, String password, String role, String status) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    
    
    public Account(String username, String password, String role, String status, String id, String citizenID, String name, Date dob, String phone, String address, String email, String adminID) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.status = status;
        this.id = id;
        this.citizenID = citizenID;
        this.name = name;
        this.dob = dob;
        this.phone = phone;
        this.address = address;
        this.email = email;
        this.adminID = adminID;
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

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    @Override
    public String toString() {
        return "Account{" + "username=" + username + ", password=" + password + ", role=" + role + ", status=" + status + ", id=" + id + ", citizenID=" + citizenID + ", name=" + name + ", dob=" + dob + ", phone=" + phone + ", address=" + address + ", email=" + email + ", adminID=" + adminID + '}';
    }
        
}
