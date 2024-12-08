<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logout</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            padding: 50px;
        }
        h2 {
            color: #2c3e50;
        }
        .message {
            padding: 20px;
            background-color: #16a085;
            color: white;
            border-radius: 5px;
            display: inline-block;
        }
    </style>
</head>
<body>

    <%
        // Invalidate the session to log the user out
        session.invalidate(); // This will clear all session attributes

        // Redirect the user to the login page after logout
        response.sendRedirect("login.jsp"); // You can replace "login.jsp" with your actual login page
    %>

</body>
</html>
