/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.security.Timestamp;

/**
 *
 * @author anhbu
 */
public class Order {
    private String id;
    private String customerId;
    private String staffId;
    private String status;
    private Timestamp time;
    private int ticketCount; // thông tin phụ thêm khi join ticket count

    public Order() {
    }

    public Order(String id, String customerId, String staffId, String status, Timestamp time, int ticketCount) {
        this.id = id;
        this.customerId = customerId;
        this.staffId = staffId;
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

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public String getStaffId() {
        return staffId;
    }

    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
    }
    
    
}
