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
    private Ticket ticket;
    private String type;
    private double weight;
    private double price;

    public Luggage() {
    }

    public Luggage(String id, Account acc, Ticket ticket, String type, double weight, double price) {
        this.id = id;
        this.acc = acc;
        this.ticket = ticket;
        this.type = type;
        this.weight = weight;
        this.price = price;
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

    public Ticket getTicket() {
        return ticket;
    }

    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Luggage{" + "id=" + id + ", acc=" + acc + ", ticket=" + ticket + ", type=" + type + ", weight=" + weight + ", price=" + price + '}';
    }

}
