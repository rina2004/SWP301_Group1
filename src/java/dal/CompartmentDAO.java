/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Type;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Compartment;

/**
 *
 * @author tungn
 */
public class CompartmentDAO extends DBContext {
    
    public void createNewCompartment(char id, String name, Type type, int capacity) {
        
        PreparedStatement stm;
        ResultSet rs;
        
        String sql = "INSERT INTO Compartment (id, name, typeID, capacity) VALUES (?, ?, ?, ?)";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, String.valueOf(id)); // Chuyển char -> String
            stm.setString(2, name);
            stm.setString(3, type.getId()); // Lấy ID của Type
            stm.setInt(4, capacity);
            
            stm.executeUpdate();
            System.out.println("Thêm khoang mới thành công!");
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Lỗi khi thêm khoang: " + e.getMessage());
        }
    }
    
    public Compartment getCompartmentWithTypeByID(String compartmentID, String typeid) {
        Compartment compartment = null;
        String sql = "SELECT c.name AS compartment_name, t.name AS type_name, c.capacity "
                + "FROM Compartment c "
                + "JOIN Type t ON c.typeID = t.id "
                + "WHERE c.id = ? AND t.id = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, compartmentID);
            stm.setString(2, typeid);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    String compartmentName = rs.getString("compartment_name");
                    String typeName = rs.getString("type_name");
                    int capacity = rs.getInt("capacity");
                    
                    Type type = new Type();
                    type.setId(typeid);
                    type.setName(typeName);                    
                    
                    compartment = new Compartment();
                    compartment.setId(compartmentID);
                    compartment.setName(compartmentName);
                    compartment.setType(type);
                    compartment.setCapacity(capacity);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return compartment;
    }
    
    public Compartment getCompartmentByID(String id, String typeID) {
        Compartment compartment = null;
        PreparedStatement stm;
        ResultSet rs;
        
        String sql = "Select * From Compartment where id = ? And typeID = ?";
        
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, String.valueOf(id));
            stm.setString(2, typeID);
            rs = stm.executeQuery();
            
            if (rs.next()) {
                String name = rs.getString("name");
                typeID = rs.getString("typeID");
                int capacity = rs.getInt("capacity");
                
                compartment = new Compartment(id, name, new Type(typeID), capacity);
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return compartment;
    }
    
    public boolean isCompartmentExist(char id, String typeid) {
        String sql = "SELECT 1 FROM Compartment c "
                + "JOIN Type t ON c.typeID = t.id "
                + "WHERE c.id = ? AND c.typeID = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, String.valueOf(id));
            stm.setString(2, typeid);
            
            try (ResultSet rs = stm.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            System.out.println("Database error in isCompartmentExist: " + e.getMessage());
        }
        return false;
    }
    
    public List<Compartment> getAllCompartment(String typeID) {
        PreparedStatement stm;
        ResultSet rs;
        
        List<Compartment> list = new ArrayList<>();
        
        String sql = "Select * From Compartment where typeID = ?";
        
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, typeID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                typeID = rs.getString("typeID");
                int capacity = rs.getInt("capacity");
                
                list.add(new Compartment(id, name, new Type(typeID), capacity));
            }
            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public void updateCompartmenByID(char id, String typeID, int newcap) {
        PreparedStatement stm;
        ResultSet rs;
        
        String sql = "UPDATE Compartment SET capacity = ? WHERE id = ? AND typeID = ?";
        
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, newcap);
            stm.setString(2, String.valueOf(id));
            stm.setString(3, typeID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    public static void main(String[] args) {
        
        CompartmentDAO dao = new CompartmentDAO();
        String id = "E";
        System.out.println(id.charAt(0));
    }
}
