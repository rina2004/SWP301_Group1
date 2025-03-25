/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Rinaaaa
 */
public class ChatMessage {
    private String id;
    private Account senderID, receiverID;
    private String message;
    private LocalDateTime timestamp;
    private boolean isRead;

    public ChatMessage() {
    }

    public ChatMessage(String id, Account senderID, Account receiverID, String message, LocalDateTime timestamp, boolean isRead) {
        this.id = id;
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.message = message;
        this.timestamp = timestamp;
        this.isRead = isRead;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Account getSenderID() {
        return senderID;
    }

    public void setSenderID(Account senderID) {
        this.senderID = senderID;
    }

    public Account getReceiverID() {
        return receiverID;
    }

    public void setReceiverID(Account receiverID) {
        this.receiverID = receiverID;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    
}
