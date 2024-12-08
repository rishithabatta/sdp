<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register for Course</title>
    <style>
        /* Sidebar styling */
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

        /* Content styling */
        .content {
            margin-left: 250px; /* Make space for the sidebar */
            padding: 20px;
            text-align: center; /* Center the content */
        }

        h2 {
            color: #333;
        }

        p {
            font-size: 18px;
        }

        a {
            font-size: 18px;
            color: #4E7E87;
            text-decoration: none;
            padding: 10px 15px;
            border: 1px solid #4E7E87;
            border-radius: 5px;
        }

        a:hover {
            background-color: #4E7E87;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <%@ include file="/sidebar.jsp" %>

    <div class="content">
        <h2>Register for Course</h2>

        <%
            String courseId = request.getParameter("course_id"); // Get course_id from URL

            if (courseId != null) {
                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/courses"; // Your DB connection string
                    String dbUser = "root";  // Replace with your database username
                    String dbPassword = "Root";  // Replace with your database password

                    // Establish the connection
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    // SQL query to insert a new registration
                    String insertQuery = "INSERT INTO course_registrations (course_id) VALUES (?)";
                    ps = conn.prepareStatement(insertQuery);
                    ps.setInt(1, Integer.parseInt(courseId));

                    // Execute the query
                    int rowsAffected = ps.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p style='color:green;'>Successfully registered for Course ID: " + courseId + "!</p>");
                    } else {
                        out.println("<p style='color:red;'>Error registering for the course.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p style='color:red;'>No course selected for registration.</p>");
            }
        %>

        <br>
        <a href="courses.jsp">Back to Courses</a>
    </div>
</body>
</html>