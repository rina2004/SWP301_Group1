/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tungn
 */
public class Seat {
    
    private String id;
    private Compartment compartment;
    private String available;

    public Seat() {
    }

    public Seat(String id, Compartment compartment, String available) {
        this.id = id;
        this.compartment = compartment;
        this.available = available;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Compartment getCompartment() {
        return compartment;
    }

    public void setCompartment(Compartment compartment) {
        this.compartment = compartment;
    }

    public String getAvailable() {
        return available;
    }

    public void setAvailable(String available) {
        this.available = available;
    }

    @Override
    public String toString() {
        return "Seat{" + "id=" + id + ", compartment=" + compartment + ", available=" + available + '}';
    }

    
    
}
