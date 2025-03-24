/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author A A
 */
public class Ticket {
    private String id;
    private String orderId;
    private String flightId;
    private String seatId;
    private String type;
    private double price;
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

    public Ticket() {
    }

    public Ticket(String id, String orderId, String flightId, String seatId, String type, double price, String status) {
        this.id = id;
        this.orderId = orderId;
        this.flightId = flightId;
        this.seatId = seatId;
        this.type = type;
        this.price = price;
        this.status = status;
    }

    public Ticket(String id, String orderId, String flightId, String seatId, String type, double price, String status, String flightName, String flightCode, LocalDateTime startingTime, LocalDateTime landingTime, String departureName, String destinationName, String seatCode, String compartmentName) {
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
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getFlightId() {
        return flightId;
    }

    public void setFlightId(String flightId) {
        this.flightId = flightId;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFlightName() {
        return flightName;
    }

    public void setFlightName(String flightName) {
        this.flightName = flightName;
    }

    public String getFlightCode() {
        return flightCode;
    }

    public void setFlightCode(String flightCode) {
        this.flightCode = flightCode;
    }

    public LocalDateTime getStartingTime() {
        return startingTime;
    }

    public void setStartingTime(LocalDateTime startingTime) {
        this.startingTime = startingTime;
    }

    public LocalDateTime getLandingTime() {
        return landingTime;
    }

    public void setLandingTime(LocalDateTime landingTime) {
        this.landingTime = landingTime;
    }

    public String getDepartureName() {
        return departureName;
    }

    public void setDepartureName(String departureName) {
        this.departureName = departureName;
    }

    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getSeatCode() {
        return seatCode;
    }

    public void setSeatCode(String seatCode) {
        this.seatCode = seatCode;
    }

    public String getCompartmentName() {
        return compartmentName;
    }

    public void setCompartmentName(String compartmentName) {
        this.compartmentName = compartmentName;
    }
    
    

   
    
}
