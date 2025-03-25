/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author A A
 */
public class Luggage {
    private int id;
    private Account customer;
    private Order order;
    private String type;
    private double checkedweight;
    private double handedweight;
    private boolean existed;

    public Luggage() {
    }

    public Luggage(int id, Account customer, Order order, String type, double checkedweight, double handedweight, boolean existed) {
        this.id = id;
        this.customer = customer;
        this.order = order;
        this.type = type;
        this.checkedweight = checkedweight;
        this.handedweight = handedweight;
        this.existed = existed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Account getCustomer() {
        return customer;
    }

    public void setCustomer(Account customer) {
        this.customer = customer;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public double getCheckedweight() {
        return checkedweight;
    }

    public void setCheckedweight(double checkedweight) {
        this.checkedweight = checkedweight;
    }

    public double getHandedweight() {
        return handedweight;
    }

    public void setHandedweight(double handedweight) {
        this.handedweight = handedweight;
    }

    public boolean isExisted() {
        return existed;
    }

    public void setExisted(boolean existed) {
        this.existed = existed;
    }
    
    
    
}
