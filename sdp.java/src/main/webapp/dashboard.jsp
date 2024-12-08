<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        /* General font styling */
        body {
            font-family: 'Arial', sans-serif; /* Reuse Arial font */
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        
        /* Side Navbar styles */
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #4E7E87;
            padding-top: 20px;
            font-family: 'Arial', sans-serif; /* Sidebar font */
        }
        
        .sidebar a {
            padding: 12px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            transition: background-color 0.3s;
            font-family: 'Arial', sans-serif; /* Link font */
        }
        
        .sidebar a:hover {
            background-color: #575757;
        }

        /* Main content area */
        .content {
            margin-left: 250px; /* Offset the main content by sidebar width */
            padding: 20px;
            font-family: 'Arial', sans-serif; /* Content font */
        }

        /* Navbar at the top */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            margin-left: 250px;
            font-family: 'Arial', sans-serif; /* Navbar font */
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
            font-family: 'Arial', sans-serif; /* Navbar link font */
        }

        .navbar ul li a:hover {
            background-color: #0056b3;
        }

        /* Content text styling */
        .content h2 {
            color: #333;
            font-family: 'Arial', sans-serif; /* Header font */
        }
    </style>
</head>
<body>

    <!-- Side Navbar -->
    <div class="sidebar">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="courses.jsp">Courses</a>
        <a href="viewTimetable.jsp">Timetable</a>
        <a href="login.jsp">Logout</a>
    </div>

    <!-- Main Content Area -->
    <div class="content">
        <!-- Welcome message -->
        <h1>Welcome, <%= request.getParameter("username") != null ? request.getParameter("username") : "Guest" %>!</h1>
        
        <!-- Motivational message -->
        <p><b>"Unlock your creativity, one course at a time! Register today and turn your ideas into awesome prototypes that make a difference. Let's get building!"</b></p>
    </div>

</body>
</html>
