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
public class Order {

    private String id;
    private Account account;
    private String status;
    private Date time;
    private double finalPrice;
    private int finalNum;

    public Order() {
    }

    public Order(String id, Account account, String status, Date time, double finalPrice, int finalNum) {
        this.id = id;
        this.account = account;
        this.status = status;
        this.time = time;
        this.finalPrice = finalPrice;
        this.finalNum = finalNum;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
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

    @Override
    public String toString() {
        return "Order{" + "id=" + id + ", account=" + account + ", status=" + status + ", time=" + time + ", finalPrice=" + finalPrice + ", finalNum=" + finalNum + '}';
    }
 
    
    
  
}
