/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author A A
 */
public class Ticket {
    private String id;
    private Order order;
    private Seat seat;
    private String type;
    private String status;
    
    // Các trường mở rộng
    private String flightName;
    private String flightCode;
    private LocalDateTime startingTime;
    private LocalDateTime landingTime;
    private String departureName;
    private String destinationName;
    private String seatCode;
    private String compartmentName;
    
     // Các trường bổ sung từ TicketType
    private TicketType ticketType;
    
    
    // Các trường bổ sung từ Airplane (qua Compartment)
    private String airplaneId;
    private String airplaneName;
    
    //Danh sách hành khách đi cùng vé này (thuộc order)
    private List<OrderPassenger> passengers;

    public Ticket() {
    }

    public Ticket(String id, Order order, Seat seat, String type, String status) {
        this.id = id;
        this.order = order;
        this.seat = seat;
        this.type = type;
        this.status = status;
    }

    public Ticket(String id, String orderId, String flightId, String seatId, String type, double price, String status, String flightName, String flightCode, LocalDateTime startingTime, LocalDateTime landingTime, String departureName, String destinationName, String seatCode, String compartmentName, TicketType ticketType, String airplaneId, String airplaneName, List<OrderPassenger> passengers) {
        this.id = id;
        this.orderId = orderId;
        this.flightId = flightId;
        this.seatId = seatId;
        this.type = type;
        this.price = price;
        this.status = status;
        this.flightName = flightName;
        this.flightCode = flightCode;
        this.startingTime = startingTime;
        this.landingTime = landingTime;
        this.departureName = departureName;
        this.destinationName = destinationName;
        this.seatCode = seatCode;
        this.compartmentName = compartmentName;
        this.ticketType = ticketType;
        this.airplaneId = airplaneId;
        this.airplaneName = airplaneName;
        this.passengers = passengers;
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

    public Seat getSeat() {
        return seat;
    }

    public void setSeat(Seat seat) {
        this.seat = seat;
    }

    public String getSeatId() {
        return seatId;
    }

    public void setSeatId(String seatId) {
        this.seatId = seatId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
