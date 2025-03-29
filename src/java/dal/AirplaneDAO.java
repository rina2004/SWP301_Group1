/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import model.Airplane;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AirplaneStatus;
import model.Compartment;
import model.Seat;
import model.TicketType;

/**
 *
 * @author Rinaaaa
 */
public class AirplaneDAO extends DBContext {

    public void insert(Airplane airplane) {
        try {
            connection.setAutoCommit(false);
            String createAirplane = """ 
                                    INSERT INTO swp301.airplane 
                                    (id, name, statusID, numOfComs, maintainanceTime, usedTime)
                                    VALUES (?, ?, ?, ? ,?, ?)
                                    """;
            String insertCompartment = """
                                       INSERT INTO swp301.compartment (id, type, airplaneID, capacity) 
                                       VALUES (?, ?, ?, ?)
                                       """;
            String insertSeat = """
                                INSERT INTO swp301.seat (id, compartmentid, status) 
                                VALUES (?, ?, ?)
                                """;

            PreparedStatement stm_createAirplane = connection.prepareStatement(createAirplane);
            stm_createAirplane.setString(1, airplane.getId());
            stm_createAirplane.setString(2, airplane.getName());
            stm_createAirplane.setInt(3, airplane.getStatus().getId());
            stm_createAirplane.setInt(4, airplane.getNumOfComs());
            stm_createAirplane.setTimestamp(5, Timestamp.valueOf(airplane.getMaintainanceTime()));
            stm_createAirplane.setTimestamp(6, Timestamp.valueOf(airplane.getUsedTime()));
            stm_createAirplane.executeUpdate();

            for (Compartment compartment : airplane.getCompartments()) {
                PreparedStatement stm_insertCompartment = connection.prepareStatement(insertCompartment);
                stm_insertCompartment.setString(1, compartment.getId());
                stm_insertCompartment.setString(2, compartment.getType().getType());
                stm_insertCompartment.setString(3, airplane.getId());
                stm_insertCompartment.setInt(4, compartment.getCapacity());
                stm_insertCompartment.executeUpdate();

                for (Seat seat : compartment.getSeats()) {
                    PreparedStatement stm_insertSeat = connection.prepareStatement(insertSeat);
                    stm_insertSeat.setString(1, seat.getId());
                    stm_insertSeat.setString(2, compartment.getId());
                    stm_insertSeat.setString(3, seat.getStatus());
                    stm_insertSeat.executeUpdate();
                }
            }
            connection.commit();
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public Airplane get(String id) {
        Airplane airplane = null;
        String sql = "SELECT * FROM swp301.airplane WHERE id = ?";

        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                airplane = new Airplane();
                airplane.setId(rs.getString("id"));
                airplane.setName(rs.getString("name"));
                airplane.setStatus(as.get(rs.getInt("statusID")));
                airplane.setNumOfComs(rs.getInt("numOfComs"));
                airplane.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                airplane.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return airplane;
    }

    public ArrayList<Airplane> list() {
        ArrayList<Airplane> planes = new ArrayList<>();
        AirplaneStatusDBContext as = new AirplaneStatusDBContext();
        String sql = "SELECT * FROM swp301.airplane";
        try (PreparedStatement stm = connection.prepareStatement(sql);) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Airplane plane = new Airplane();
                plane.setId(rs.getString("id"));
                plane.setName(rs.getString("name"));
                plane.setStatus(as.get(rs.getInt("statusID")));
                plane.setNumOfComs(rs.getInt("numOfComs"));
                plane.setMaintainanceTime(rs.getTimestamp("maintainanceTime").toLocalDateTime());
                plane.setUsedTime(rs.getTimestamp("usedTime").toLocalDateTime());

                planes.add(plane);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return planes;
    }

    public Airplane getDetail(String id) {
        Airplane airplane = null;
        try {
            String queryAirplane = """
                        SELECT id, name, statusID, numOfComs, maintainanceTime, usedTime 
                        FROM airplane 
                        WHERE id = ?
                        """;
            PreparedStatement stmAirplane = connection.prepareStatement(queryAirplane);
            stmAirplane.setString(1, id);
            ResultSet rsAirplane = stmAirplane.executeQuery();

            if (rsAirplane.next()) {
                airplane = new Airplane();
                airplane.setId(rsAirplane.getString("id"));
                airplane.setName(rsAirplane.getString("name"));
                airplane.setNumOfComs(rsAirplane.getInt("numOfComs"));
                airplane.setMaintainanceTime(rsAirplane.getTimestamp("maintainanceTime").toLocalDateTime());
                airplane.setUsedTime(rsAirplane.getTimestamp("usedTime").toLocalDateTime());

                AirplaneStatus status = new AirplaneStatus();
                status.setId(rsAirplane.getInt("statusID"));
                airplane.setStatus(status);
            } else {
                return null;
            }

            String queryCompartment = """
                        SELECT id, type, capacity 
                        FROM compartment 
                        WHERE airplaneID = ?
                        """;
            PreparedStatement stmCompartment = connection.prepareStatement(queryCompartment);
            stmCompartment.setString(1, id);
            ResultSet rsCompartment = stmCompartment.executeQuery();

            ArrayList<Compartment> compartments = new ArrayList<>();
            while (rsCompartment.next()) {
                Compartment compartment = new Compartment();
                compartment.setId(rsCompartment.getString("id"));

                TicketType ticketType = new TicketType();
                ticketType.setType(rsCompartment.getString("type"));
                compartment.setType(ticketType);

                compartment.setCapacity(rsCompartment.getInt("capacity"));
                compartment.setAirplane(airplane);
                compartments.add(compartment);
            }

            for (Compartment compartment : compartments) {
                String querySeat = """
                            SELECT id, status 
                            FROM seat 
                            WHERE compartmentid = ?
                            """;
                PreparedStatement stmSeat = connection.prepareStatement(querySeat);
                stmSeat.setString(1, compartment.getId());
                ResultSet rsSeat = stmSeat.executeQuery();

                ArrayList<Seat> seats = new ArrayList<>();
                while (rsSeat.next()) {
                    Seat seat = new Seat();
                    seat.setId(rsSeat.getString("id"));
                    seat.setStatus(rsSeat.getString("status"));
                    seats.add(seat);
                }
                compartment.setSeats(seats);
            }

            airplane.setCompartments(compartments);

        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return airplane;
    }

    public void update(Airplane airplane) {
        try {
            connection.setAutoCommit(false);

            String updateAirplane = """
                                UPDATE swp301.airplane 
                                SET statusID = ?, numOfComs = ?, 
                                    maintainanceTime = ?, usedTime = ?
                                WHERE id = ?
                                """;
            PreparedStatement stm_updateAirplane = connection.prepareStatement(updateAirplane);
            stm_updateAirplane.setInt(1, airplane.getStatus().getId());
            stm_updateAirplane.setInt(2, airplane.getNumOfComs());
            stm_updateAirplane.setTimestamp(3, Timestamp.valueOf(airplane.getMaintainanceTime()));
            stm_updateAirplane.setTimestamp(4, Timestamp.valueOf(airplane.getUsedTime()));
            stm_updateAirplane.setString(5, airplane.getId());
            stm_updateAirplane.executeUpdate();

            String updateCompartment = """
                                       UPDATE swp301.compartment
                                       SET capacity = ?
                                       WHERE id = ?
                                       """;
            for (Compartment compartment : airplane.getCompartments()) {
                PreparedStatement stm_updateCompartment = connection.prepareStatement(updateCompartment);
                stm_updateCompartment.setInt(1, compartment.getCapacity());
                stm_updateCompartment.setString(2, compartment.getId());
                stm_updateCompartment.executeUpdate();

                String updateSeat = """
                                UPDATE swp301.seat 
                                SET status = ? 
                                WHERE id = ?
                                """;
                for (Seat seat : compartment.getSeats()) {
                    PreparedStatement stm_updateSeat = connection.prepareStatement(updateSeat);
                    stm_updateSeat.setString(1, seat.getStatus());
                    stm_updateSeat.setString(2, seat.getId());
                    stm_updateSeat.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException ex) {
            Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex1);
            }
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AirplaneDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
