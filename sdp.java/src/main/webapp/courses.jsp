<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('courses.png') no-repeat center center fixed;
            background-size: cover;
            color: #333;
        }

        /* Sidebar styling */
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: rgba(78, 126, 135, 0.9); /* Slightly transparent for better visibility */
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
            margin-left: 250px;
            padding: 20px;
            background: rgba(255, 255, 255, 0.9); /* Slightly transparent background for better readability */
            border-radius: 8px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        p {
            text-align: center;
            color: #0056b3;
            font-size: 16px;
        }

        /* Grid container */
        .course-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px auto;
            max-width: 1200px;
        }

        /* Individual course cards */
        .course-card {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        }

        .course-card h3 {
            font-size: 18px;
            color: #333;
            margin: 10px 0;
        }

        .course-card a {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #0056b3;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
        }

        .course-card a:hover {
            background-color: #004494;
        }
    </style>
</head>
<body>
    <!-- Including sidebar.jsp -->
    <%@ include file="/sidebar.jsp" %>
    

    <div class="content">
        <h2>Courses</h2>
        <p>Registering today means more learning, more fun, and more prototypes to bring to life.</p>

        <div class="course-grid">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String selectQuery = "SELECT * FROM courses"; // Query to select all courses

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/courses"; // Your DB connection string
                    String dbUser = "root";  // Replace with your database username
                    String dbPassword = "Root";  // Replace with your database password

                    // Establish the connection
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    ps = conn.prepareStatement(selectQuery);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        String courseName = rs.getString("course_name");
                        int courseId = rs.getInt("course_id");
            %>
            <div class="course-card">
                <h3>"<%= courseName %>"</h3>
                <a href="register.jsp?course_id=<%= courseId %>">Register now</a>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
