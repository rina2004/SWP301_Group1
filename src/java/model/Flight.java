/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.time.*;
import java.time.format.DateTimeFormatter;
/**
 *
 * @author A A
 */
public class Flight {
    private String id;
    private String name;
    private String code;
    private Airplane airplane;
    private Location departure;
    private Location destination;
    private LocalDateTime entryTime;
    private LocalDateTime startingTime;
    private LocalDateTime landingTime;

    public Flight() {}

    public Flight(String id, String name, String code, Airplane airplane, Location departure, Location destination, LocalDateTime entryTime, LocalDateTime startingTime, LocalDateTime landingTime) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.airplane = airplane;
        this.departure = departure;
        this.destination = destination;
        this.entryTime = entryTime;
        this.startingTime = startingTime;
        this.landingTime = landingTime;
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

    public Airplane getAirplane() {
        return airplane;
    }

    public void setAirplane(Airplane airplane) {
        this.airplane = airplane;
    }

    public Location getDeparture() {
        return departure;
    }

    public void setDeparture(Location departure) {
        this.departure = departure;
    }

    public Location getDestination() {
        return destination;
    }

    public void setDestination(Location destination) {
        this.destination = destination;
    }

    public LocalDateTime getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(LocalDateTime entryTime) {
        this.entryTime = entryTime;
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

    public String getEntryDate() {
        return entryTime != null ? startingTime.toLocalDate().toString() : "";
    }

    public String getEntryHour() {
        return entryTime != null ? entryTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")) : "";
    }

    public String getStartingDate() {
        return startingTime != null ? startingTime.toLocalDate().toString() : "";
    }

    public String getStartingHour() {
        return startingTime != null ? startingTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")) : "";
    }

    public String getLandingDate() {
        return landingTime != null ? landingTime.toLocalDate().toString() : "";
    }

    public String getLandingHour() {
        return landingTime != null ? landingTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")) : "";
    }

    public String getDuration() {
        if (startingTime != null && landingTime != null) {
            Duration duration = Duration.between(startingTime, landingTime);
            long days = duration.toDays();
            long hours = duration.toHoursPart();
            long minutes = duration.toMinutesPart();

            if (days > 0) {
                return String.format("%d day%s %dh %02dm", days, (days > 1 ? "s" : ""), hours, minutes);
            } else {
                return String.format("%dh %02dm", hours, minutes);
            }
        }
        return "N/A";
    }
}
