/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author A A
 */
public class Order {

    private String id;
    private Account customer;
    private Account staff;
    private String status;
    private LocalDateTime time;
    private double finalPrice;
    private int finalNum;
    private TicketType tt;
    private List<OrderPassenger> passengers;

    public Order() {
        passengers = new ArrayList<>();
    }
    
    public Order(String id, String status, double finalPrice, int finalNum) {
        this.id = id;
        this.status = status;
        this.finalPrice = finalPrice;
        this.finalNum = finalNum;
    }

    public Order(String id, Account customer, Account staff, String status, LocalDateTime time, double finalPrice, int finalNum, TicketType tt, List<OrderPassenger> passengers) {
        this.id = id;
        this.customer = customer;
        this.staff = staff;
        this.status = status;
        this.time = time;
        this.finalPrice = finalPrice;
        this.finalNum = finalNum;
        this.tt = tt;
        this.passengers = passengers;
    }

    public Order(String id, Account customer, Account staff, String status, LocalDateTime time, double finalPrice, int finalNum, TicketType tt) {
        this.id = id;
        this.customer = customer;
        this.staff = staff;
        this.status = status;
        this.time = time;
        this.finalPrice = finalPrice;
        this.finalNum = finalNum;
        this.tt = tt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Account getCustomer() {
        return customer;
    }

    public void setCustomer(Account customer) {
        this.customer = customer;
    }

    public Account getStaff() {
        return staff;
    }

    public void setStaff(Account staff) {
        this.staff = staff;
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

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public int getFinalNum() {
        return finalNum;
    }

    public void setFinalNum(int finalNum) {
        this.finalNum = finalNum;
    }

    public TicketType getTt() {
        return tt;
    }

    public void setTt(TicketType tt) {
        this.tt = tt;
    }
    

    public List<OrderPassenger> getPassengers() {
        return passengers;
    }

    public void setPassengers(List<OrderPassenger> passengers) {
        this.passengers = passengers;
    }

   
}
