<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        /* Ensure content does not overlap with sidebar */
        .container {
            margin-left: 250px; /* Adjust margin to match the width of the sidebar */
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            margin: 20px auto;
            width: 70%;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        label {
            font-size: 16px;
            color: #333;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0 20px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="submit"], .back-button {
            background-color: #007BFF;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
        }

        input[type="submit"]:hover, .back-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <h2>Add New Course</h2>

        <form method="post">
            <label for="course_name">Course Name:</label>
            <input type="text" name="course_name" required>

            <label for="duration">Duration:</label>
            <input type="text" name="duration" required>

            <label for="faculty_id">Faculty ID:</label>
            <input type="number" name="faculty_id" required>

            <label for="faculty_name">Faculty Name:</label>
            <input type="text" name="faculty_name" required>

            <input type="submit" value="Add Course">
        </form>

        <a href="viewCourses.jsp" class="back-button">Back to View Courses</a>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String course_name = request.getParameter("course_name");
                String duration = request.getParameter("duration");
                int faculty_id = Integer.parseInt(request.getParameter("faculty_id"));
                String faculty_name = request.getParameter("faculty_name");

                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/courses"; // Replace with your actual database name
                    String dbUser = "root"; // Replace with your database username
                    String dbPassword = "Root"; // Replace with your database password

                    // Establish the connection
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // SQL query to insert a new course
                    String sql = "INSERT INTO courses (course_name, duration, faculty_id, faculty_name) VALUES (?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, course_name);
                    ps.setString(2, duration);
                    ps.setInt(3, faculty_id);
                    ps.setString(4, faculty_name);

                    // Execute the query
                    int rowsAffected = ps.executeUpdate();

                    // Check if the course was successfully added
                    if (rowsAffected > 0) {
                        // Redirect to the View Courses page after adding
                        response.sendRedirect("viewCourses.jsp");
                    } else {
        %>
                        <p class="error">Error adding course to the database.</p>
        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
        %>
                    <p class="error">Error: <%= e.getMessage() %></p>
        <%
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>
