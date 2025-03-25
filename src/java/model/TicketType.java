/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author A A
 */
public class TicketType {
    private String type;
    private String description;
    private double price;
    private double checkedweightneed;
    private double handedweightneed;

    public TicketType() {
    }

    public TicketType(String type, String description, double price, double checkedweightneed, double handedweightneed) {
        this.type = type;
        this.description = description;
        this.price = price;
        this.checkedweightneed = checkedweightneed;
        this.handedweightneed = handedweightneed;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getCheckedweightneed() {
        return checkedweightneed;
    }

    public void setCheckedweightneed(double checkedweightneed) {
        this.checkedweightneed = checkedweightneed;
    }

    public double getHandedweightneed() {
        return handedweightneed;
    }

    public void setHandedweightneed(double handedweightneed) {
        this.handedweightneed = handedweightneed;
    }

}
