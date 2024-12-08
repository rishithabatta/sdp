<%@ page import="java.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
        }

        /* Left Section */
        .left-section {
            background-color: #467287;
            color: white;
            width: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .left-section h1 {
            font-size: 3em;
        }

        /* Right Section */
        .right-section {
            width: 50%;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-container {
            max-width: 400px;
            margin: auto;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 10px;
        }

        button:hover {
            background-color: #0056b3;
        }

        .link-container {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
        }

        .link-container a {
            color: #007bff;
            text-decoration: none;
        }

        .link-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Left Section -->
    <div class="left-section">
        <div>
        <h1>STUDENT REGISTRATION</h1>
          <img src="images/logo.png" alt="Student Logo" style="max-width: 500px; height: 300px; margin-bottom: 20px;">
        </div>
    </div>

    <!-- Right Section -->
    <div class="right-section">
        <div class="form-container">
        
            <h2>Account Login</h2>
            <form action="login.jsp" method="post">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" placeholder="Enter your username" required>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <button type="submit">Login</button>
            </form>
            <div class="link-container">
                <button onclick="window.location.href='adminlogin.jsp';">Admin Login</button>
                <br>
                <a href="forgotpassword.jsp">Forgot Password?</a>
            </div>
        </div>
    </div>

    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username != null && password != null) {
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/courses"; // Change this to your DB details
                String dbUsername = "root";  // Your MySQL username
                String dbPassword = "Root";  // Your MySQL password
                con = DriverManager.getConnection(url, dbUsername, dbPassword);

                // Query to check the username and password
                String sql = "SELECT * FROM students WHERE username=? AND password=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);

                rs = pst.executeQuery();

                // If user is found
                if (rs.next()) {
                    // Redirect to student details page with the username in the query parameter
                    response.sendRedirect("dashboard.jsp?username=" + username);
                } else {
                    out.println("<p style='color: red;'>Invalid username or password.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Database error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
