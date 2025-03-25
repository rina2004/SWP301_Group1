/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tungn
 */
public class Luggage {

    private String id;
    private Account acc;
    private Order order;
    private String type;
    private double weight;
    private boolean existed;

    public Luggage() {
    }

    public Luggage(String id, Account acc, Order order, String type, double weight, boolean existed) {
        this.id = id;
        this.acc = acc;
        this.order = order;
        this.type = type;
        this.weight = weight;
        this.existed = existed;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Account getAcc() {
        return acc;
    }

    public void setAcc(Account acc) {
        this.acc = acc;
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

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public boolean isExisted() {
        return existed;
    }

    public void setExisted(boolean existed) {
        this.existed = existed;
    }

    @Override
    public String toString() {
        return "Luggage{" + "id=" + id + ", acc=" + acc + ", order=" + order + ", type=" + type + ", weight=" + weight + ", existed=" + existed + '}';
    }

   

}
