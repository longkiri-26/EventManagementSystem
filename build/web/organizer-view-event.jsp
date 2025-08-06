<%@page import="com.eventmanagement.model.User"%>
<%@page import="com.eventmanagement.dao.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eventmanagement.model.Event, com.eventmanagement.model.Registration, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Event</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Event Management</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="events">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="create-event">Create Event</a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="container mt-4">
        <% Event event = (Event) request.getAttribute("event"); %>
        
        <div class="card mb-4">
            <div class="card-body">
                <h2 class="card-title"><%= event.getTitle() %></h2>
                <p class="card-text"><%= event.getDescription() %></p>
                <p class="card-text">
                    <strong>Date:</strong> <%= event.getDate() %><br>
                    <strong>Time:</strong> <%= event.getTime() %><br>
                    <strong>Location:</strong> <%= event.getLocation() %>
                </p>
                <a href="edit-event?id=<%= event.getEventId() %>" class="btn btn-primary">Edit Event</a>
            </div>
        </div>
        
        <h3>Attendees</h3>
        <% List<Registration> registrations = (List<Registration>) request.getAttribute("attendees"); %>
        <% if (registrations != null && !registrations.isEmpty()) { %>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Attendee ID</th>
                        <th>Username</th>
                        <th>Registration Date</th>
                    </tr>
                </thead>
                <tbody>
                     <% 
                                    UserDAO userDao = new UserDAO();
                                    for (Registration reg : registrations) { 
                                        User user = userDao.getUserById(reg.getUserId());
                                    %>
                        <tr>
                            <td><%= reg.getUserId() %></td>
                            <td><%= (user != null) ? user.getUsername() : "User not found" %></td>
                            <td><%= reg.getRegistrationDate() %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="alert alert-info">No attendees registered for this event yet.</div>
        <% } %>
    </div>
</body>
</html>