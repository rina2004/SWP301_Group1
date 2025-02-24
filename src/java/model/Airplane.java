/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Rinaaaa
 */
public class Airplane {
    private String id;
    private String name;
    private Type type;
    private AirplaneStatus status;
    private LocalDateTime maintainanceTime;
    private LocalDateTime usedTime;
    private AirTrafficControl atc;

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

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public AirplaneStatus getStatus() {
        return status;
    }

    public void setStatus(AirplaneStatus status) {
        this.status = status;
    }

    public LocalDateTime getMaintainanceTime() {
        return maintainanceTime;
    }

    public void setMaintainanceTime(LocalDateTime maintainanceTime) {
        this.maintainanceTime = maintainanceTime;
    }

    public LocalDateTime getUsedTime() {
        return usedTime;
    }

    public void setUsedTime(LocalDateTime usedTime) {
        this.usedTime = usedTime;
    }

    public AirTrafficControl getAtc() {
        return atc;
    }

    public void setAtc(AirTrafficControl atc) {
        this.atc = atc;
    }
}
