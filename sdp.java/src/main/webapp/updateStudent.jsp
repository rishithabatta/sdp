<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Student</title>
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
        input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
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
        .back-button {
            width: 100%;
            padding: 10px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .back-button:hover {
            background: #218838;
        }
    </style>
</head>
<body>
 <!-- Include Sidebar -->
    <jsp:include page="adminsidebar.jsp" />
    <div class="container">
        <h2>Update Student</h2>

        <%
            String message = "";
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String studentId = request.getParameter("studentId");
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String age = request.getParameter("age");
                String username = request.getParameter("username");
                String phoneNumber = request.getParameter("phonenumber");

                // Database connection details
                String jdbcURL = "jdbc:mysql://localhost:3306/coursemanagement";
                String jdbcUsername = "root"; // Update this
                String jdbcPassword = "Root"; // Update this

                // SQL update query
                String sql = "UPDATE students SET name = ?, email = ?, password = ?, age = ?, username = ?, phone_number = ? WHERE student_id = ?";

                try {
                    // Load the JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Create a connection to the database
                    Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

                    // Prepare the statement
                    PreparedStatement preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, name);
                    preparedStatement.setString(2, email);
                    preparedStatement.setString(3, password);
                    preparedStatement.setInt(4, Integer.parseInt(age));
                    preparedStatement.setString(5, username);
                    preparedStatement.setString(6, phoneNumber);
                    preparedStatement.setInt(7, Integer.parseInt(studentId));

                    // Execute the update
                    int rowAffected = preparedStatement.executeUpdate();
                    if (rowAffected > 0) {
                        message = "Student details updated successfully!";
                    } else {
                        message = "Error updating student details.";
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

        <form action="updateStudent.jsp" method="post">
            <div class="form-group">
                <label for="studentId">Student ID</label>
                <input type="text" id="studentId" name="studentId" placeholder="Enter student ID" required>
            </div>
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" placeholder="Enter student name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter student email" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter student password" required>
            </div>
            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" id="age" name="age" placeholder="Enter student age" required>
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="Enter student username" required>
            </div>
            <div class="form-group">
                <label for="phone_number">Phone Number</label>
                <input type="text" id="phone_number" name="phone_number" placeholder="Enter student phone number" required>
            </div>
            <button type="submit">Update Student</button>
        </form>

        <!-- Back to View Students button -->
        <form action="viewStudents.jsp">
            <button type="submit" class="back-button">Back to View Students</button>
        </form>
    </div>
</body>
</html>
