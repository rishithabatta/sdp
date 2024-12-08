<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        /* Sidebar Styling */
.sidebar {
    width: 200px;               /* Set the width of the sidebar */
    height: 100vh;              /* Set the height of the sidebar to fill the entire viewport */
    background-color: #2c3e50;  /* Set the background color to a dark blue-gray */
    color: white;               /* Set the text color to white */
    padding-top: 20px;          /* Add top padding to the sidebar */
    position: fixed;            /* Fix the sidebar's position to the left side of the screen */
}

.sidebar a {
    color: white;               /* Set the text color of links to white */
    text-decoration: none;      /* Remove underline from links */
    display: block;             /* Make links block elements to fill the sidebar's width */
    padding: 10px;              /* Add padding inside each link */
    margin: 10px 0;             /* Add vertical margin between links */
    background-color: #34495e;  /* Set the background color of each link to a dark gray */
    border-radius: 5px;         /* Add rounded corners to each link */
}

.sidebar a:hover {
    background-color: #1abc9c;  /* Change the background color of the link on hover */
}
        

        /* Main content styles */
        .content {
            margin-left: 250px; /* Offset the content area by sidebar width */
            padding: 20px;
        }

        /* Navbar styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            margin-left: 250px;
        }

        .navbar h1 {
            margin: 0;
            font-size: 24px;
        }

        .navbar ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .navbar ul li {
            margin: 0 10px;
        }

        .navbar ul li a {
            text-decoration: none;
            color: white;
            font-size: 16px;
            padding: 8px 12px;
            border-radius: 4px;
        }

        .navbar ul li a:hover {
            background-color: #0056b3;
        }

        /* Heading and content text */
        .content h2 {
            color: #333;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="viewStudents.jsp">Students</a>
        <a href="viewCourses.jsp">Courses</a>
        <a href="addToTimetable.jsp">Schedule</a>
        <a href="login.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h2>Welcome to the Admin Dashboard</h2>
        <p>Use the navigation links to manage students, courses, and schedules.</p>
    </div>

</body>
</html>
