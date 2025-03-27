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
    private CompartmentType ct;
    private Airplane airplane;
    private int capacity;
    
    private ArrayList<Seat> seats = new ArrayList<>();

    public Compartment() {
    }

    public Compartment(String id, CompartmentType ct, Airplane airplane, int capacity) {
        this.id = id;
        this.ct = ct;
        this.airplane = airplane;
        this.capacity = capacity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public CompartmentType getCt() {
        return ct;
    }

    public void setCt(CompartmentType ct) {
        this.ct = ct;
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
}
