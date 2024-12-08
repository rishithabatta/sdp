<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 100px auto;
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
        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background: #0056b3;
        }
        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Remove Student</h2>

        <%
            String message = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String studentId = request.getParameter("studentId");

                // Database connection details
                String jdbcURL = "jdbc:mysql://localhost:3306/courses";
                String jdbcUsername = "root"; // Update this
                String jdbcPassword = "Root"; // Update this

                // SQL delete query
                String sql = "DELETE FROM students WHERE student_id = ?";

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Create a connection to the database
                    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                    // Prepare the statement
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setInt(1, Integer.parseInt(studentId));

                    // Execute the delete
                    int rowAffected = preparedStatement.executeUpdate();
                    if (rowAffected > 0) {
                        message = "Student removed successfully!";
                    } else {
                        message = "Error: Student ID not found.";
                    }

                    // Close the connection
                    connection.close();
                } catch (Exception e) {
                    message = "Error: " + e.getMessage();
                }
            }
        %>

        <!-- Display error or success message -->
        <p class="error"><%= message %></p>

        <form action="removeStudent.jsp" method="post">
            <div class="form-group">
                <label for="studentId">Student ID</label>
                <input type="text" id="studentId" name="studentId" placeholder="Enter student ID to remove" required>
            </div>
            <button type="submit">Remove Student</button>
        </form>
    </div>
</body>
</html>
