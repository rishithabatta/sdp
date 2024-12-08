<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager,java.sql.PreparedStatement,java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>

    <% 
        String email = request.getParameter("email");
        String message = "";
        String password = null;
        
        if (email != null && !email.isEmpty()) {
            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/courses";  // Update with your DB URL
            String dbUsername = "root";  // Update with your DB username
            String dbPassword = "Root";  // Update with your DB password

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                // Establish the connection to the database
                Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                
                // Query to check if the email exists
                String sql = "SELECT password FROM users WHERE email = ?";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, email);
                
                ResultSet resultSet = statement.executeQuery();
                
                // If a record is found, retrieve the password
                if (resultSet.next()) {
                    password = resultSet.getString("password");
                    message = "The password for <strong>" + email + "</strong> is: " + password;
                } else {
                    message = "No account found for the provided email.";
                }
                
                // Close connections
                resultSet.close();
                statement.close();
                conn.close();
            } catch (Exception e) {
                message = "An error occurred: " + e.getMessage();
            }
        }
    %>

    <!-- Form to input email -->
    <form method="post">
        <label for="email">Enter your email:</label>
        <input type="email" id="email" name="email" required>
        <button type="submit">Retrieve Password</button>
    </form>

    <!-- Display message if email is submitted -->
    <% if (email != null && !email.isEmpty()) { %>
        <p><%= message %></p>
    <% } %>
</body>
</html>
