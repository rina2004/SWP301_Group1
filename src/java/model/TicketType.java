/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author anhbu
 */
public class TicketType {
    private String type;
    private String description;
    private double checkedLuggageWeight;
    private double handLuggageWeight;
    private int luggageQuantity;
    private String additionalServices;

    public TicketType() {
    }

    public TicketType(String type, String description, double checkedLuggageWeight, double handLuggageWeight, int luggageQuantity, String additionalServices) {
        this.type = type;
        this.description = description;
        this.checkedLuggageWeight = checkedLuggageWeight;
        this.handLuggageWeight = handLuggageWeight;
        this.luggageQuantity = luggageQuantity;
        this.additionalServices = additionalServices;
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

    public String getAdditionalServices() {
        return additionalServices;
    }

    public void setAdditionalServices(String additionalServices) {
        this.additionalServices = additionalServices;
    }
    
    
}
