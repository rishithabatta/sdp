<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%;
            max-width: 400px;
            margin: 80px auto;
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
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background: #4E7E87; /* Updated button color */
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background: #0056b3;
        }
        .links {
            text-align: center;
            margin-top: 10px;
        }
        .links a {
            color: #007BFF;
            text-decoration: none;
        }
        .links a:hover {
            text-decoration: underline;
        }
        .error {
            color: red;
            text-align: center;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Login</h2>
        <!-- Error Message Display -->
        <% 
            String errorMessage = null;
            String username = request.getParameter("adminUsername");
            String password = request.getParameter("adminPassword");
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                if ("admin".equals(username) && "admin".equals(password)) {
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    errorMessage = "Invalid credentials";
                }
            }
        %>
        <% if (errorMessage != null) { %>
            <div class="error"><%= errorMessage %></div>
        <% } %>
        <form method="post">
            <div class="form-group">
                <label for="adminUsername">Admin Username</label>
                <input type="text" id="adminUsername" name="adminUsername" placeholder="Enter admin username" required>
            </div>
            <div class="form-group">
                <label for="adminPassword">Admin Password</label>
                <input type="password" id="adminPassword" name="adminPassword" placeholder="Enter admin password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <div class="links">
            <a href="login.jsp">Back to User Login</a>
        </div>
    </div>
</body>
</html>
