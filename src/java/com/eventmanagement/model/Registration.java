package com.eventmanagement.model;

import java.sql.Timestamp;

public class Registration {
    private int registrationId;
    private int eventId;
    private int userId;
    private Timestamp registrationDate;

    public Registration() {}
    
    public Registration(int registrationId, int eventId, int userId, Timestamp registrationDate) {
        this.registrationId = registrationId;
        this.eventId = eventId;
        this.userId = userId;
        this.registrationDate = registrationDate;
    }

    // Getters and Setters
    public int getRegistrationId() { return registrationId; }
    public void setRegistrationId(int registrationId) { this.registrationId = registrationId; }
    public int getEventId() { return eventId; }
    public void setEventId(int eventId) { this.eventId = eventId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Timestamp getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Timestamp registrationDate) { this.registrationDate = registrationDate; }
}