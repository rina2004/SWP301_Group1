/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author A A
 */
public class Ticket {
    private String id;
    private OrderPassenger orderPassenger;
    private Flight flight;
    private Compartment compartment;
    private Seat seat;
    private String status;

    public Ticket() {
    }

    public Ticket(String id, OrderPassenger orderPassenger, Flight flight, Compartment compartment, Seat seat, String status) {
        this.id = id;
        this.orderPassenger = orderPassenger;
        this.flight = flight;
        this.compartment = compartment;
        this.seat = seat;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public OrderPassenger getOrderPassenger() {
        return orderPassenger;
    }

    public void setOrderPassenger(OrderPassenger orderPassenger) {
        this.orderPassenger = orderPassenger;
    }

    public Flight getFlight() {
        return flight;
    }

    public void setFlight(Flight flight) {
        this.flight = flight;
    }

    public Compartment getCompartment() {
        return compartment;
    }

    public void setCompartment(Compartment compartment) {
        this.compartment = compartment;
    }

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

   
    
}
