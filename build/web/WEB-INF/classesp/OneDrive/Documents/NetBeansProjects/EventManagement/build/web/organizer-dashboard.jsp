<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.eventmanagement.model.User, com.eventmanagement.model.Event, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Organizer Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .empty-state {
            text-align: center;
            padding: 40px;
        }
        .empty-state-icon {
            font-size: 60px;
            color: #6c757d;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Event Management</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
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
        <h2>My Events</h2>
        
        <% 
        List<Event> events = (List<Event>) request.getAttribute("events");
        User user = (User) session.getAttribute("user");
        
        // Debugging information (remove in production)
        System.out.println("DEBUG: User in session: " + (user != null ? user.getUsername() : "null"));
        System.out.println("DEBUG: Events in request: " + (events != null ? events.size() : "null"));
        %>
        
        <% if (user == null) { %>
            <div class="alert alert-danger">
                You are not logged in. Please <a href="login">login</a> to view your events.
            </div>
        <% } else if (events == null) { %>
            <div class="alert alert-warning">
                <a href="events">View Event</a> or <a href="create-event">Create Event</a>
            </div>
        <% } else if (events.isEmpty()) { %>
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-calendar-plus"></i>
                </div>
                <h4>No Events Found</h4>
                <p>You haven't created any events yet.</p>
                <a href="create-event" class="btn btn-primary">Create Your First Event</a>
            </div>
        <% } else { %>
            <div class="row">
                <% for (Event event : events) { %>
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="card-title"><%= event.getTitle() %></h5>
                                <p class="card-text text-truncate"><%= event.getDescription() %></p>
                                <p class="card-text">
                                    <small class="text-muted">
                                        <i class="fas fa-calendar-day"></i> <%= event.getDate() %><br>
                                        <i class="fas fa-clock"></i> <%= event.getTime() %><br>
                                        <i class="fas fa-map-marker-alt"></i> <%= event.getLocation() %>
                                    </small>
                                </p>
                            </div>
                            <div class="card-footer bg-transparent">
                                <a href="view-event?id=<%= event.getEventId() %>" class="btn btn-primary btn-sm">View</a>
                                <a href="edit-event?id=<%= event.getEventId() %>" class="btn btn-secondary btn-sm">Edit</a>
                                <a href="delete-event?id=<%= event.getEventId() %>" class="btn btn-danger btn-sm" 
                                   onclick="return confirm('Are you sure you want to delete this event?')">Delete</a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <!-- Font Awesome for icons -->
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>