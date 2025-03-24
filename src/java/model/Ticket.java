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
    
     // Các trường bổ sung từ TicketType
    private double handLuggageWeight;
    private double checkedLuggageWeight;
    private int luggageQuantity;
    private String additionalServices;
    
    // Các trường bổ sung từ Airplane (qua Compartment)
    private String airplaneId;
    private String airplaneName;
    
    //Danh sách hành khách đi cùng vé này (thuộc order)
    private List<OrderPassenger> passengers;

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

    public Ticket(String id, String orderId, String flightId, String seatId, String type, double price, String status, String flightName, String flightCode, LocalDateTime startingTime, LocalDateTime landingTime, String departureName, String destinationName, String seatCode, String compartmentName, double handLuggageWeight, double checkedLuggageWeight, int luggageQuantity, String additionalServices, String airplaneId, String airplaneName, List<OrderPassenger> passengers) {
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
        this.handLuggageWeight = handLuggageWeight;
        this.checkedLuggageWeight = checkedLuggageWeight;
        this.luggageQuantity = luggageQuantity;
        this.additionalServices = additionalServices;
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

    public double getHandLuggageWeight() {
        return handLuggageWeight;
    }

    public void setHandLuggageWeight(double handLuggageWeight) {
        this.handLuggageWeight = handLuggageWeight;
    }

    public double getCheckedLuggageWeight() {
        return checkedLuggageWeight;
    }

    public void setCheckedLuggageWeight(double checkedLuggageWeight) {
        this.checkedLuggageWeight = checkedLuggageWeight;
    }

    public int getLuggageQuantity() {
        return luggageQuantity;
    }

    public void setLuggageQuantity(int luggageQuantity) {
        this.luggageQuantity = luggageQuantity;
    }

    public String getAdditionalServices() {
        return additionalServices;
    }

    public void setAdditionalServices(String additionalServices) {
        this.additionalServices = additionalServices;
    }

    public String getAirplaneId() {
        return airplaneId;
    }

    public void setAirplaneId(String airplaneId) {
        this.airplaneId = airplaneId;
    }

    public String getAirplaneName() {
        return airplaneName;
    }

    public void setAirplaneName(String airplaneName) {
        this.airplaneName = airplaneName;
    }

    public List<OrderPassenger> getPassengers() {
        return passengers;
    }

    public void setPassengers(List<OrderPassenger> passengers) {
        this.passengers = passengers;
    }

    
    
}
