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
    private String checkedweightneed;
    private String handedweightneed;

    public TicketType() {
    }

    public TicketType(String type, String description, double price, String checkedweightneed, String handedweightneed) {
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

    public String getCheckedweightneed() {
        return checkedweightneed;
    }

    public void setCheckedweightneed(String checkedweightneed) {
        this.checkedweightneed = checkedweightneed;
    }

    public String getHandedweightneed() {
        return handedweightneed;
    }

    public void setHandedweightneed(String handedweightneed) {
        this.handedweightneed = handedweightneed;
    }
    
}
