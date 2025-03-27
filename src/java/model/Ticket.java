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
    private OrderPassenger orderP;
    private Flight flight;
    private Seat seat;
    private String status;

    public Ticket() {
    }

    public Ticket(String id, OrderPassenger orderP, Flight flight, Seat seat, String status) {
        this.id = id;
        this.orderP = orderP;
        this.flight = flight;
        this.seat = seat;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public OrderPassenger getOrderP() {
        return orderP;
    }

    public void setOrderP(OrderPassenger orderP) {
        this.orderP = orderP;
    }

    public Flight getFlight() {
        return flight;
    }

    public void setFlight(Flight flight) {
        this.flight = flight;
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
