/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tungn
 */
public class TicketType {
    private String type;
    private String description;
    private double price;
    private double checkedLuggageWeight;
    private double handLuggageWeight;
    private int luggageQuantity;
    private String  additionalService;

    public TicketType() {
    }

    public TicketType(String type, String description, double price, double checkedLuggageWeight, double handLuggageWeight, int luggageQuantity, String additionalService) {
        this.type = type;
        this.description = description;
        this.price = price;
        this.checkedLuggageWeight = checkedLuggageWeight;
        this.handLuggageWeight = handLuggageWeight;
        this.luggageQuantity = luggageQuantity;
        this.additionalService = additionalService;
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

    public double getCheckedLuggageWeight() {
        return checkedLuggageWeight;
    }

    public void setCheckedLuggageWeight(double checkedLuggageWeight) {
        this.checkedLuggageWeight = checkedLuggageWeight;
    }

    public double getHandLuggageWeight() {
        return handLuggageWeight;
    }

    public void setHandLuggageWeight(double handLuggageWeight) {
        this.handLuggageWeight = handLuggageWeight;
    }

    public int getLuggageQuantity() {
        return luggageQuantity;
    }

    public void setLuggageQuantity(int luggageQuantity) {
        this.luggageQuantity = luggageQuantity;
    }

    public String getAdditionalService() {
        return additionalService;
    }

    public void setAdditionalService(String additionalService) {
        this.additionalService = additionalService;
    }

    @Override
    public String toString() {
        return "TicketType{" + "type=" + type + ", description=" + description + ", price=" + price + ", checkedLuggageWeight=" + checkedLuggageWeight + ", handLuggageWeight=" + handLuggageWeight + ", luggageQuantity=" + luggageQuantity + ", additionalService=" + additionalService + '}';
    }    
}
