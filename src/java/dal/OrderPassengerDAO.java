/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.*;
import java.util.logging.*;

/**
 *
 * @author A A
 */
public class OrderPassengerDAO extends DBContext {

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

    public List<OrderPassenger> getAllByOrderID(String orderID) {
        PreparedStatement stm;
        ResultSet rs;
       String sql = "SELECT op.*, n.name, pt.name as name "
               + "FROM OrderPassenger op "
               + "JOIN Nation n ON op.nationID = n.id "
               + "JOIN PassengerType pt ON op.passengerTypeID = pt.id "
               + "WHERE op.orderID = ?";
        List<OrderPassenger> list = new ArrayList<>();
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, orderID);
            rs = stm.executeQuery();

            while (rs.next()) {
                Nation nation = new Nation();
                nation.setId(rs.getInt("nationID"));
                nation.setName(rs.getString("name"));
                PassengerType type = new PassengerType();
                type.setId(rs.getInt("passengerTypeID"));
                type.setName(rs.getString("pt.name"));
                OrderPassenger pass = new OrderPassenger();
                pass.setId(rs.getString("id"));
                pass.setName(rs.getString("fullname"));
                pass.setDob(rs.getDate("dob"));
                pass.setNation(nation);
                pass.setPassengerType(type);
                list.add(pass);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        OrderPassengerDAO dao = new OrderPassengerDAO();
        List<OrderPassenger> list = dao.getAllByOrderID("ORD001");

        for (OrderPassenger orderPassenger : list) {
            System.out.println(orderPassenger.toString());
        }

    }
}
