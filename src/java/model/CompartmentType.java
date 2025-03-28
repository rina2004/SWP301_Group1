/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tungn
 */
public class CompartmentType {
    private char id;
    private String name;

    public CompartmentType() {
    }

    public CompartmentType(char id, String name) {
        this.id = id;
        this.name = name;
    }

    public char getId() {
        return id;
    }

    public void setId(char id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "CompartmentType{" + "id=" + id + ", name=" + name + '}';
    }

    
    
    
}
