/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.FlightDAO;
import dal.TicketDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Flight;
import model.Ticket;

/**
 *
 * @author A A
 */
public class NewClass {
    public static void main(String[] args) throws SQLException, Exception {
        FlightDAO dao = new FlightDAO();
        List<Flight> l = dao.getFlightsByPriceRange(0, 200);
        System.out.println(l);
    }
}
