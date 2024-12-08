<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-left: 250px; /* Adjusted to ensure no overlap with sidebar */
            max-width: 600px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        input[type="number"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            text-align: center;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .btn.back {
            background-color: #28a745;
        }
        .btn.back:hover {
            background-color: #218838;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
        .success {
            color: green;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <h2>Remove Course</h2>
        <form action="removeCourse.jsp" method="post">
            <div class="form-group">
                <label for="courseId">Course ID</label>
                <input type="number" id="courseId" name="courseId" placeholder="Enter Course ID to Remove" required>
            </div>
            <button type="submit" class="btn">Remove Course</button>
        </form>
        <a href="viewCourses.jsp" class="btn back">Back to View Courses</a>

        <% 
            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/courses";
            String dbUser = "root";
            String dbPassword = "Root";

            if (request.getMethod().equalsIgnoreCase("POST")) {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                
                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                    // Prepare the SQL delete query
                    String deleteQuery = "DELETE FROM courses WHERE course_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(deleteQuery);
                    stmt.setInt(1, courseId);
                    
                    // Execute the delete query
                    int rowsDeleted = stmt.executeUpdate();
                    
                    if (rowsDeleted > 0) {
        %>
                        <p class="success">Course removed successfully!</p>
        <% 
                    } else {
        %>
                        <p class="error">Course not found!</p>
        <%
                    }
                } catch (SQLException e) {
        %>
                    <p class="error">Error removing course: <%= e.getMessage() %></p>
        <%
                }
            }
        %>
    </div>
</body>
</html>
