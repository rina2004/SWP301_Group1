package dal;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import model.*;
/**
 *
 * @author A A
 */
public class SeatDAO extends DBContext {
    public Seat get(String id) {
        CompartmentDAO cd = new CompartmentDAO();
        String sql = "SELECT * FROM swp301.seat WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return new Seat(rs.getString("id"),
                        cd.get(rs.getString("compartmentID")),
                        rs.getString("status"),
                        rs.getString("reason"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
