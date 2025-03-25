/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author Rinaaaa
 */
public class Airplane {
    private String id;
    private String name;
    private int numOfComs;
    private AirplaneStatus status;
    private LocalDateTime maintainanceTime;
    private LocalDateTime usedTime;
    
    private ArrayList<Compartment> compartments = new ArrayList<>();

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

    public int getNumOfComs() {
        return numOfComs;
    }

    public void setNumOfComs(int numOfComs) {
        this.numOfComs = numOfComs;
    }

    public AirplaneStatus getStatus() {
        return status;
    }

    public void setStatus(AirplaneStatus status) {
        this.status = status;
    }

    public LocalDateTime getMaintainanceTime() {
        return maintainanceTime;
    }

    public void setMaintainanceTime(LocalDateTime maintainanceTime) {
        this.maintainanceTime = maintainanceTime;
    }

    public LocalDateTime getUsedTime() {
        return usedTime;
    }

    public void setUsedTime(LocalDateTime usedTime) {
        this.usedTime = usedTime;
    }

    public ArrayList<Compartment> getCompartments() {
        return compartments;
    }

    public void setCompartments(ArrayList<Compartment> compartments) {
        this.compartments = compartments;
    }
}