/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author A A
 */
public class Ticket {
    private String id;
    private Order order;
    private Seat seat;
    private String status;
    
    // Các trường mở rộng
    private String flightName;
    private String flightCode;
    private LocalDateTime startingTime;
    private LocalDateTime landingTime;
    private String departureName;
    private String destinationName;
    private String seatCode;
    private String compartmentName;
    
        
    // Các trường bổ sung từ Airplane (qua Compartment)
    private String airplaneId;
    private String airplaneName;
    
    //Danh sách hành khách đi cùng vé này (thuộc order)
    private List<OrderPassenger> passengers;

    public Ticket() {
    }

   

}
