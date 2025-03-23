/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Rinaaaa
 */
public class Compartment {
    private char id;
    private String name;
    private Airplane airplaneID;
    private int capacity;

    public Compartment() {
    }

    public Compartment(char id, String name, Airplane airplaneID, int capacity) {
        this.id = id;
        this.name = name;
        this.airplaneID = airplaneID;
        this.capacity = capacity;
    }
    
    public char getId() {
        return id;
    }

    public void setId(char id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Airplane getAirplaneID() {
        return airplaneID;
    }

    public void setAirplaneID(Airplane airplaneID) {
        this.airplaneID = airplaneID;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }
}
