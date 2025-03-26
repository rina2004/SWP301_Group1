package model;
import java.time.LocalDateTime;
/**
 *
 * @author A A
 */
public class Order {
    private String id;
    private Account customer;
    private Account staff;
    private String status;
    private LocalDateTime time;
    private double finalPrice;
    private int finalNum;
    public Order() {
    }
    public Order(String id, Account customer, Account staff, String status, LocalDateTime time, double finalPrice, int finalNum) {
        this.id = id;
        this.customer = customer;
        this.staff = staff;
        this.status = status;
        this.time = time;
        this.finalPrice = finalPrice;
        this.finalNum = finalNum;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public Account getCustomer() {
        return customer;
    }

    public void setCustomer(Account customer) {
        this.customer = customer;
    }

    public Account getStaff() {
        return staff;
    }

    public void setStaff(Account staff) {
        this.staff = staff;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }

    public double getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public int getFinalNum() {
        return finalNum;
    }

    public void setFinalNum(int finalNum) {
        this.finalNum = finalNum;
    }

    
}
