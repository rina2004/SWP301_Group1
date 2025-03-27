package dal;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import model.*;

/**
 *
 * @author A A
 */
public class FlightDAO extends DBContext {
    public ArrayList<Flight> list() {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.flight";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        ld.getById(rs.getInt("departure")),
                        ld.getById(rs.getInt("destination")),
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public Flight getFlightById(String id) {
        String sql = "SELECT * FROM Flight WHERE id = ?";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try (PreparedStatement stm = connection.prepareStatement(sql)){
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Location departure = ld.getById(rs.getInt("departure"));
                Location destination = ld.getById(rs.getInt("destination"));
                return new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        departure,
                        destination,
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public Flight getFlightByName(String name) {
        String sql = "SELECT * FROM Flight WHERE name = ?";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, name);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Location departure = ld.getById(rs.getInt("departure"));
                Location destination = ld.getById(rs.getInt("destination"));
                return new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        departure,
                        destination,
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    public Flight getFlightByCode(String code) {
        String sql = "SELECT * FROM Flight WHERE code = ?";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, code);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Location departure = ld.getById(rs.getInt("departure"));
                Location destination = ld.getById(rs.getInt("destination"));
                return new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        departure,
                        destination,
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Flight> filterFlightsByPrice(String priceRange) {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = """
            SELECT f.* FROM Flight f 
            WHERE f.price BETWEEN ? AND ?
            ORDER BY f.price ASC""";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            switch (priceRange) {
                case "cheap" -> {
                    stm.setInt(1, 0);
                    stm.setInt(2, 1000000);
                }
                case "medium" -> {
                    stm.setInt(1, 1000001);
                    stm.setInt(2, 3000000);
                }
                case "expensive" -> {
                    stm.setInt(1, 3000001);
                    stm.setInt(2, Integer.MAX_VALUE);
                }
                default -> {
                    return list;
                }
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        ld.getById(rs.getInt("departure")),
                        ld.getById(rs.getInt("destination")),
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<Flight> searchFlightsByName(String searchTerm) {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = """
            SELECT f.* FROM swp301.flight f 
            LEFT JOIN Location ld ON f.departure = ld.id
            LEFT JOIN Location la ON f.destination = la.id
            WHERE f.name LIKE ? OR ld.name LIKE ? OR la.name LIKE ?
            """;
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            stm.setString(1, searchPattern);
            stm.setString(2, searchPattern);
            stm.setString(3, searchPattern);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Location departure = ld.getById(rs.getInt("departure"));
                Location destination = ld.getById(rs.getInt("destination"));

                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        departure,
                        destination,
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<Flight> search(String departure, String destination, String startingDate) {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = """
            SELECT f.* FROM flight f 
            LEFT JOIN Location ld ON f.departure = ld.id
            LEFT JOIN Location la ON f.destination = la.id
            WHERE ld.name LIKE ? 
            AND la.name LIKE ? 
            AND DATE(f.startingTime) LIKE ?
            """;
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + departure + "%");
            stm.setString(2, "%" + destination + "%");
            stm.setString(3, "%" + startingDate + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Location departureLocation = ld.getById(rs.getInt("departure"));
                Location destinationLocation = ld.getById(rs.getInt("destination"));
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        departureLocation,
                        destinationLocation,
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public void insert(Flight flight) {
        String sql = "INSERT INTO swp301.flight VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, flight.getId());
            stm.setString(2, flight.getName());
            stm.setString(3, flight.getCode());
            stm.setString(4, flight.getAirplane().getId());
            stm.setInt(5, flight.getDeparture().getId());
            stm.setInt(6, flight.getDestination().getId());
            stm.setTimestamp(7, Timestamp.valueOf(flight.getEntryTime()));
            stm.setTimestamp(8, Timestamp.valueOf(flight.getStartingTime()));
            stm.setTimestamp(9, Timestamp.valueOf(flight.getLandingTime()));
            stm.setInt(10, flight.getPrice());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public String getHighestFlightId() {
        String sql = "SELECT MAX(id) FROM swp301.flight WHERE id LIKE 'FL%'";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public String getHighestFlightCode() {
        String sql = "SELECT MAX(code) FROM swp301.flight WHERE code LIKE 'VN%'";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println("Error getting highest flight code: " + e.getMessage());
        }
        return null;
    }
    public void update(Flight flight) {
        String sql = "UPDATE Flight SET departure=?, "
                + "destination=?, entryTime=?, startingTime=?, landingTime=?, price=? WHERE id=?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, flight.getDeparture().getId());
            stm.setInt(2, flight.getDestination().getId());
            stm.setTimestamp(3, Timestamp.valueOf(flight.getEntryTime()));
            stm.setTimestamp(4, Timestamp.valueOf(flight.getStartingTime()));
            stm.setTimestamp(5, Timestamp.valueOf(flight.getLandingTime()));
            stm.setInt(6, flight.getPrice());
            stm.setString(7, flight.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public ArrayList<Flight> ascendingPrice() {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.flight order by price asc";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        ld.getById(rs.getInt("departure")),
                        ld.getById(rs.getInt("destination")),
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    public ArrayList<Flight> descendingPrice() {
        ArrayList<Flight> list = new ArrayList<>();
        String sql = "SELECT * FROM swp301.flight order by price desc";
        AirplaneDAO ad = new AirplaneDAO();
        LocationDAO ld = new LocationDAO();
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Flight(
                        rs.getString("id"),
                        rs.getString("name"),
                        rs.getString("code"),
                        ad.get(rs.getString("airplaneID")),
                        ld.getById(rs.getInt("departure")),
                        ld.getById(rs.getInt("destination")),
                        rs.getTimestamp("entryTime").toLocalDateTime(),
                        rs.getTimestamp("startingTime").toLocalDateTime(),
                        rs.getTimestamp("landingTime").toLocalDateTime(),
                        rs.getInt("price")));
            }
        } catch (SQLException ex) {
            Logger.getLogger(FlightDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
}
