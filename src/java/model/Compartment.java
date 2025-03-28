/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author Rinaaaa
 */
public class Compartment {
    private String id;
    private CompartmentType type;
    private Airplane airplane;
    private int capacity;
    
    private ArrayList<Seat> seats = new ArrayList<>();

    public Compartment() {
    }

    public Compartment(String id, CompartmentType type, Airplane airplane, int capacity) {
        this.id = id;
        this.type = type;
        this.airplane = airplane;
        this.capacity = capacity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public CompartmentType getType() {
        return type;
    }

    public void setType(CompartmentType type) {
        this.type = type;
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

    public ArrayList<Seat> getSeats() {
        return seats;
    }

    public void setSeats(ArrayList<Seat> seats) {
        this.seats = seats;
    }

    @Override
    public String toString() {
        return "Compartment{" + "id=" + id + ", type=" + type + ", airplane=" + airplane + ", capacity=" + capacity + ", seats=" + seats + '}';
    }

   
}
