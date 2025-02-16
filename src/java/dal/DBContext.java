/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Rinaaaa
 */
public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String user = "root";
            String pass = "12345678";
            String url = "jdbc:mysql://localhost:3306/swp301?useSSL=false&serverTimezone=UTC";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void main(String[] args) {
        DBContext db = new DBContext();
        Connection conn = db.connection;

        if (conn != null) {
            System.out.println("Kết nối database thành công!");
        } else {
            System.out.println("Kết nối database thất bại!");
        }
    }
}