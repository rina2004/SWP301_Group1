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
    private String name;
    private Airplane airplane;
    private int capacity;

    public Compartment() {
    }

    public Compartment(String id, String name, Airplane airplane, int capacity) {
        this.id = id;
        this.name = name;
        this.airplane = airplane;
        this.capacity = capacity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    @Override
    public String toString() {
        return "Compartment{" + "id=" + id + ", name=" + name + ", airplane=" + airplane + ", capacity=" + capacity + '}';
    }

}
