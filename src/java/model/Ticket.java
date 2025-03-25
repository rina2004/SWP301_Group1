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
    private Order order;
    private TicketType type;
    private Seat seat;
    private String status;

    public Ticket() {
    }

    public Ticket(String id, Order order, TicketType type, Seat seat, String status) {
        this.id = id;
        this.order = order;
        this.type = type;
        this.seat = seat;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public TicketType getType() {
        return type;
    }

    public void setType(TicketType type) {
        this.type = type;
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

    @Override
    public String toString() {
        return "Ticket{" + "id=" + id + ", order=" + order + ", type=" + type + ", seat=" + seat + ", status=" + status + '}';
    }
}
