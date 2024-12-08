<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin - Add Course to Timetable</title>
    <style>
        /* Basic Styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .sidebar {
            width: 200px;
            height: 100vh;
            background-color: #2c3e50;
            color: white;
            padding-top: 20px;
            position: fixed;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            padding: 10px;
            margin: 10px 0;
            background-color: #34495e;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #1abc9c;
        }
        .content {
            margin-left: 220px;
            padding: 20px;
            width: calc(100% - 220px);
        }
        .content h2 {
            color: #2c3e50;
        }
        form label {
            display: block;
            margin: 10px 0 5px;
        }
        form input {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        form button {
            padding: 10px 15px;
            background-color: #1abc9c;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        form button:hover {
            background-color: #16a085;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
        <h2 style="text-align: center; color: white;">Admin Dashboard</h2>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="viewStudents.jsp">Students</a>
        <a href="viewCourses.jsp">Courses</a>
        <a href="addToTimetable.jsp">Schedule</a>
        <a href="logout.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h2>Admin - Add Course to Student Timetable</h2>
        <form action="addToTimetable.jsp" method="POST">
            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" required><br><br>

            <label for="courseId">Course ID:</label>
            <input type="text" id="courseId" name="courseId" required><br><br>

            <label for="courseName">Course Name:</label>
            <input type="text" id="courseName" name="courseName" required><br><br>

            <label for="startTime">Start Time (HH:MM:SS):</label>
            <input type="time" id="startTime" name="startTime" required><br><br>

            <label for="endTime">End Time (HH:MM:SS):</label>
            <input type="time" id="endTime" name="endTime" required><br><br>

            <label for="day">Day:</label>
            <input type="text" id="day" name="day" required><br><br>

            <button type="submit">Add Course to Timetable</button>
        </form>

        <%
            // Backend logic for processing the form submission
            String studentId = request.getParameter("studentId");
            String courseId = request.getParameter("courseId");
            String courseName = request.getParameter("courseName");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            String day = request.getParameter("day");

            if (studentId != null && courseId != null && courseName != null && startTime != null && endTime != null && day != null) {
                Connection con = null;
                PreparedStatement pst = null;

                try {
                    // Database connection details
                    String dbURL = "jdbc:mysql://localhost:3306/courses"; // Change to your database name
                    String dbUsername = "root";  // Your database username
                    String dbPassword = "Root";  // Your database password

                    // Load the MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Create connection to the database
                    con = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                    // SQL query to insert a new entry into the timetable
                    String sql = "INSERT INTO timetable (student_id, course_id, course_name, start_time, end_time, day) VALUES (?, ?, ?, ?, ?, ?)";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, studentId);
                    pst.setString(2, courseId);
                    pst.setString(3, courseName);
                    pst.setString(4, startTime);
                    pst.setString(5, endTime);
                    pst.setString(6, day);

                    int rowsAffected = pst.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p>Course '" + courseName + "' successfully added to timetable!</p>");
                    } else {
                        out.println("<p>Error adding course to timetable. Please try again.</p>");
                    }

                } catch (SQLException e) {
                    out.println("<p>SQLException: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (pst != null) {
                            pst.close();
                        }
                        if (con != null) {
                            con.close();
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>

</body>
</html>
