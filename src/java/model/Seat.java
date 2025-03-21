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
    private String status;
    private String reason;

    public Seat() {
    }

    public Seat(String id, Compartment compartment, String status, String reason) {
        this.id = id;
        this.compartment = compartment;
        this.status = status;
        this.reason = reason;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Override
    public String toString() {
        return "Seat{" + "id=" + id + ", compartment=" + compartment + ", status=" + status + ", reason=" + reason + '}';
    }

   
    
    
    
}
