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
public class Flight {

    private String id;
    private String name;
    private String code;
    private String airplaneId;
    private String departure;
    private String destination;
    private Date entryTime; 
    private Date startingTime;
    private Date landingTime;
    private byte[] atcId;

    public Flight() {
    }

    public Flight(String id, String name, String code, String airplaneId, String departure, String destination, Date entryTime, Date startingTime, Date landingTime, byte[] atcId) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.airplaneId = airplaneId;
        this.departure = departure;
        this.destination = destination;
        this.entryTime = entryTime;
        this.startingTime = startingTime;
        this.landingTime = landingTime;
        this.atcId = atcId;
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

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAirplaneId() {
        return airplaneId;
    }

    public void setAirplaneId(String airplaneId) {
        this.airplaneId = airplaneId;
    }

    public String getDeparture() {
        return departure;
    }

    public void setDeparture(String departure) {
        this.departure = departure;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public Date getStartingTime() {
        return startingTime;
    }

    public void setStartingTime(Date startingTime) {
        this.startingTime = startingTime;
    }

    public Date getLandingTime() {
        return landingTime;
    }

    public void setLandingTime(Date landingTime) {
        this.landingTime = landingTime;
    }

    public byte[] getAtcId() {
        return atcId;
    }

    public void setAtcId(byte[] atcId) {
        this.atcId = atcId;
    }
}
