/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author Rinaaaa
 */
public class ChatMessage {
    private String id, senderID, receiverID, message;
    private Timestamp timestamp;
    private boolean isRead;

    public ChatMessage(String id, String senderID, String receiverID, String message, Timestamp timestamp, boolean isRead) {
        this.id = id;
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.message = message;
        this.timestamp = timestamp;
        this.isRead = isRead;
    }

    public String getId() { return id; }
    public String getSenderID() { return senderID; }
    public String getReceiverID() { return receiverID; }
    public String getMessage() { return message; }
    public Timestamp getTimestamp() { return timestamp; }
    public boolean isRead() { return isRead; }
}
