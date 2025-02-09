/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.FlightDAO;
import java.util.Scanner;
import model.Flight;

/**
 *
 * @author A A
 */
public class NewClass {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        FlightDAO dao = new FlightDAO();
        Flight f = dao.getFlightById("F001");
        System.out.println(f);
    }
}
