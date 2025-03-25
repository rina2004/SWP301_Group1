/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import model.Account;
import model.Luggage;
import model.Ticket;

/**
 *
 * @author tungn
 */
public class LuggageDAO extends DBContext {
    
    public void addLuggage(String customerID, String ticketID, String type) {
        PreparedStatement stm;
        String sql = "Insert Into Luggage(id, customerID, ticketID, type, weight, price) Value (?,?,?,?,?,?)";
        
        try {
            stm = connection.prepareStatement(sql);
            Random random = new Random();
            String luggageID = "L" + random.nextInt(999);
            
            double weight = 0;
            double price = 0;
            String lugggagetype = "";
            switch (type) {
                case "Economy":
                    weight = 7.00;
                    lugggagetype = "Carry-on";
                    break;
                case "Bussiness":
                    weight = 10.00;
                    lugggagetype = "Carry-on";
                    addExtraLuggage(customerID, ticketID, "Checked", 20.00, 0.0);
                    break;
                case "First Class":
                    weight = 10.00;
                    lugggagetype = "Carry-on";
                    addExtraLuggage(customerID, ticketID, "Checked", 40.00, 0.0);
                    break;
            }
            stm.setString(1, luggageID);
            stm.setString(2, customerID);
            stm.setString(3, ticketID);
            stm.setString(4, lugggagetype);
            stm.setDouble(5, weight);
            stm.setDouble(6, price);
            
            stm.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public void addExtraLuggage(String customerID, String ticketID, String type, double weight, double price) {
        PreparedStatement stm;
        String sql = "Insert Into Luggage(id, customerID, ticketID, type, weight, price) Values (?,?,?,?,?,?)";
        
        try {
            stm = connection.prepareStatement(sql);
            Random random = new Random();
            String luggageid = "L" + random.nextInt(999999);
            
            stm.setString(1, luggageid);
            stm.setString(2, customerID);
            stm.setString(3, ticketID);
            stm.setString(4, type);
            stm.setDouble(5, weight);
            stm.setDouble(6, price);
            
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public List<Luggage> getLuggagebyCustomerID(String customerID) {
        PreparedStatement stm;
        ResultSet rs;
        List<Luggage> list = new ArrayList<>();
        String sql = "Select * From Luggage where customerID = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, customerID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Account acc = new Account();
                acc.setId(rs.getString("customerID"));
                Luggage luggage = new Luggage();
                luggage.setId(rs.getString("id"));
                luggage.setAcc(acc);
                luggage.setType(rs.getString("type"));
                luggage.setWeight(rs.getDouble("weight"));
                list.add(luggage);
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public static void main(String[] args) {
        LuggageDAO dao = new LuggageDAO();
        String customerID = "f2738d94-097f-11f0-af18-047c163442e4";
        List<Luggage> list = dao.getLuggagebyCustomerID(customerID);
        
        for (Luggage luggage : list) {
            System.out.println(luggage.toString());
        }
    }
    
}
