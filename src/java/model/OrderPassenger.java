/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
/**
 *
 * @author A A
 */
public class OrderPassenger {
    private String id;
    private Order order;
    private PassengerType passengerType;
    private String name;
    private Date dob;
    private Nation nation;

    public OrderPassenger() {
    }

    public OrderPassenger(String id, Order order, PassengerType passengerType, String name, Date dob, Nation nation) {
        this.id = id;
        this.order = order;
        this.passengerType = passengerType;
        this.name = name;
        this.dob = dob;
        this.nation = nation;
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

    public PassengerType getPassengerType() {
        return passengerType;
    }

    public void setPassengerType(PassengerType passengerType) {
        this.passengerType = passengerType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public Nation getNation() {
        return nation;
    }

    public void setNation(Nation nation) {
        this.nation = nation;
    }

    @Override
    public String toString() {
        return "OrderPassenger{" + "id=" + id + ", order=" + order + ", passengerType=" + passengerType + ", name=" + name + ", dob=" + dob + ", nation=" + nation + '}';
    }
    
}
