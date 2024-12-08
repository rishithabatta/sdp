<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sidebar</title>
    <style>
        /* General font styling */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        
        /* Sidebar styles */
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #4E7E87;
            padding-top: 20px;
        }

        .sidebar a {
            padding: 12px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        /* Content area (if you plan to include content within this file) */
        .content {
            margin-left: 250px;
            padding: 20px;
        }

    </style>
</head>
<body>

    <!-- Sidebar Menu -->
    <div class="sidebar">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="courses.jsp">Courses</a>
        <a href="viewTimetable.jsp">Timetable</a>
        <a href="login.jsp">Logout</a>
    </div>

</body>
</html>
