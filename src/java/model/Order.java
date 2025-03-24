/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import java.time.LocalDateTime;

/**
 *
 * @author anhbu
 */
public class Order {
    private String id;
    private Account customerID;
    private Account staffID;
    private String status;
    private LocalDateTime time;
    private int ticketCount; // thông tin phụ thêm khi join ticket count

    public Order() {
    }

    public Order(String id, Account customerID, Account staffID, String status, LocalDateTime time, int ticketCount) {
        this.id = id;
        this.customerID = customerID;
        this.staffID = staffID;
        this.status = status;
        this.time = time;
        this.ticketCount = ticketCount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Account getCustomerID() {
        return customerID;
    }

    public void setCustomerID(Account customerID) {
        this.customerID = customerID;
    }

    public Account getStaffID() {
        return staffID;
    }

    public void setStaffID(Account staffID) {
        this.staffID = staffID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
    }
    
    

    
}
