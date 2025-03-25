/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author A A
 */
public class PassengerType {
    private int id;
    private String name;
    private int ageMin;
    private int ageMax;
    private int discount;

    public PassengerType() {
    }

    public PassengerType(int id, String name, int ageMin, int ageMax, int discount) {
        this.id = id;
        this.name = name;
        this.ageMin = ageMin;
        this.ageMax = ageMax;
        this.discount = discount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAgeMin() {
        return ageMin;
    }

    public void setAgeMin(int ageMin) {
        this.ageMin = ageMin;
    }

    public int getAgeMax() {
        return ageMax;
    }

    public void setAgeMax(int ageMax) {
        this.ageMax = ageMax;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
}
