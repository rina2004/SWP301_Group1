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
    private String id;
    private CompartmentType cType;
    private Airplane airplane;
    private int capacity;

    public Compartment() {
    }

    public Compartment(String id) {
        this.id = id;
    }

    public Compartment(String id, CompartmentType cType, Airplane airplane, int capacity) {
        this.id = id;
        this.cType = cType;
        this.airplane = airplane;
        this.capacity = capacity;
    }
    
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public CompartmentType getcType() {
        return cType;
    }

    public void setcType(CompartmentType cType) {
        this.cType = cType;
    }

    public Airplane getAirplane() {
        return airplane;
    }

    public void setAirplane(Airplane airplane) {
        this.airplane = airplane;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    
    
}
