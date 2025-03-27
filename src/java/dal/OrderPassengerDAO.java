/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import model.*;
import java.util.logging.*;
/**
 *
 * @author A A
 */
public class OrderPassengerDAO extends DBContext{
    public OrderPassenger get(String id) {
        OrderDAO od = new OrderDAO();
        PassengerTypeDAO ptd = new PassengerTypeDAO();
        NationDAO nd = new NationDAO();
        String sql = "SELECT * FROM swp301.orderpassenger WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new OrderPassenger(
                        rs.getString("id"),
                        od.get(rs.getString("orderID")),
                        ptd.get(rs.getString("passengerTypeID")),
                        rs.getString("fullName"),
                        rs.getDate("dob"),
                        nd.get(rs.getString("nationID")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderPassengerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
