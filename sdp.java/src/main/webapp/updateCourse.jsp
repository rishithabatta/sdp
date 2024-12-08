<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Course</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-left: 250px; /* Ensure content does not overlap with the sidebar */
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

        input[type="text"], input[type="number"] {
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

        .message {
            text-align: center;
            margin: 15px 0;
            font-size: 18px;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="adminsidebar.jsp" />

    <div class="container">
        <h2>Update Course</h2>
        <form method="post">
            <div class="form-group">
                <label for="courseId">Course ID</label>
                <input type="number" id="courseId" name="courseId" placeholder="Enter Course ID" required>
            </div>
            <div class="form-group">
                <label for="courseName">Course Name</label>
                <input type="text" id="courseName" name="courseName" placeholder="Enter Course Name" required>
            </div>
            <div class="form-group">
                <label for="duration">Duration (in months)</label>
                <input type="number" id="duration" name="duration" placeholder="Enter Duration" required>
            </div>
            <div class="form-group">
                <label for="facultyId">Faculty ID</label>
                <input type="number" id="facultyId" name="facultyId" placeholder="Enter Faculty ID" required>
            </div>
            <div class="form-group">
                <label for="facultyName">Faculty Name</label>
                <input type="text" id="facultyName" name="facultyName" placeholder="Enter Faculty Name" required>
            </div>
            <button type="submit" class="btn">Update Course</button>
        </form>
        <a href="viewCourses.jsp" class="btn back">Back to View Courses</a>

        <% 
            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/courses";
            String dbUser = "root";
            String dbPassword = "Root";
            
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String courseName = request.getParameter("courseName");
                int duration = Integer.parseInt(request.getParameter("duration"));
                int facultyId = Integer.parseInt(request.getParameter("facultyId"));
                String facultyName = request.getParameter("facultyName");
                
                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                    // Prepare the SQL update query
                    String updateQuery = "UPDATE courses SET course_name = ?, duration = ?, faculty_id = ?, faculty_name = ? WHERE course_id = ?";
                    PreparedStatement stmt = conn.prepareStatement(updateQuery);
                    stmt.setString(1, courseName);
                    stmt.setInt(2, duration);
                    stmt.setInt(3, facultyId);
                    stmt.setString(4, facultyName);
                    stmt.setInt(5, courseId);
                    
                    // Execute the update query
                    int rowsUpdated = stmt.executeUpdate();
                    
                    if (rowsUpdated > 0) {
        %>
                        <p class="message success">Course updated successfully!</p>
        <%
                    } else {
        %>
                        <p class="message error">Course not found!</p>
        <%
                    }
                } catch (SQLException e) {
        %>
                    <p class="message error">Error updating course: <%= e.getMessage() %></p>
        <%
                }
            }
        %>
    </div>
</body>
</html>
