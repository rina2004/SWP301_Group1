/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.util.logging.*;
import model.*;

/**
 *
 * @author tungn
 */
public class CompartmentTypeDAO extends DBContext{
    public CompartmentType get(String id) {
        String sql = "SELECT * FROM swp301.compartmenttype WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new CompartmentType(rs.getString("id").charAt(0),
                        rs.getString("name"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CompartmentTypeDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public static void main(String[] args) {
        CompartmentTypeDAO dao = new CompartmentTypeDAO();
        CompartmentType t = dao.get("B");
        System.out.println(t.toString());
    }
}
