package com.eventmanagement.dao;

import com.eventmanagement.model.Registration;
import com.eventmanagement.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegistrationDAO {
    public boolean registerForEvent(int eventId, int userId) {
        String sql = "INSERT INTO registrations (event_id, user_id) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean isRegistered(int eventId, int userId) {
        String sql = "SELECT * FROM registrations WHERE event_id = ? AND user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Registration> getRegistrationsByUser(int userId) {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM registrations WHERE user_id = ? ORDER BY registration_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    registrations.add(new Registration(
                        rs.getInt("registration_id"),
                        rs.getInt("event_id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("registration_date")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }
    
    public List<Registration> getRegistrationsByEvent(int eventId) {
        List<Registration> registrations = new ArrayList<>();
        String sql = "SELECT * FROM registrations WHERE event_id = ? ORDER BY registration_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    registrations.add(new Registration(
                        rs.getInt("registration_id"),
                        rs.getInt("event_id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("registration_date")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return registrations;
    }
    
    public boolean cancelRegistration(int eventId, int userId) {
        String sql = "DELETE FROM registrations WHERE event_id = ? AND user_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, eventId);
            stmt.setInt(2, userId);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}