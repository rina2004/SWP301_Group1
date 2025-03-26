/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Compartment;

/**
 *
 * @author A A
 */
public class NewClass {
    public static void main(String[] args) {
        CompartmentDAO cd = new CompartmentDAO();
        ArrayList<Compartment> list = cd.getCompartmentsByFlightId("FL001");
        for (Compartment c : list) {
            System.out.println(c.getType().getPrice());
        }
    }
}
