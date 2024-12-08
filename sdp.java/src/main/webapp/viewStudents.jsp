<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            margin-left: 250px;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .success {
            text-align: center;
            color: green;
            font-size: 18px;
        }

        .error {
            text-align: center;
            color: red;
            font-size: 18px;
        }

        .button-container {
            text-align: right;
            margin-bottom: 15px;
        }

        .button {
            padding: 10px 15px;
            background-color: #007BFF;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            cursor: pointer;
        }

        .button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="adminsidebar.jsp" />

    <!-- Main Content -->
    <div class="container">
        <h2>Students List</h2>

        <!-- Add Student Button -->
        <div class="button-container">
            <a href="addStudent.jsp" class="button">Add Student</a>
        </div>

        <!-- Display success or error messages -->
        <%
            String successMessage = request.getParameter("success");
            String errorMessage = request.getParameter("error");

            if (successMessage != null) {
        %>
            <p class="success"><%= successMessage %></p>
        <%
            }

            if (errorMessage != null) {
        %>
            <p class="error"><%= errorMessage %></p>
        <%
            }
        %>

        <!-- Table to display student data -->
        <table>
            <thead>
                <tr>
                    <th>Student ID</th>
                    <th>Username</th>
                    <th>Student Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Age</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String jdbcURL = "jdbc:mysql://localhost:3306/courses";
                    String jdbcUsername = "root";
                    String jdbcPassword = "Root";
                    String sql = "SELECT student_id, username, student_name, email, phonenumber, age FROM students";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                        PreparedStatement preparedStatement = connection.prepareStatement(sql);
                        ResultSet resultSet = preparedStatement.executeQuery();

                        while (resultSet.next()) {
                            int studentId = resultSet.getInt("student_id");
                            String username = resultSet.getString("username");
                            String studentName = resultSet.getString("student_name");
                            String email = resultSet.getString("email");
                            String phoneNumber = resultSet.getString("phonenumber");
                            int age = resultSet.getInt("age");
                %>
                            <tr>
                                <td><%= studentId %></td>
                                <td><%= username %></td>
                                <td><%= studentName %></td>
                                <td><%= email %></td>
                                <td><%= phoneNumber %></td>
                                <td><%= age %></td>
                                <td>
                                    <a href="updateStudent.jsp?studentId=<%= studentId %>">Update</a> |
                                    <a href="removeStudent.jsp?studentId=<%= studentId %>">Remove</a>
                                </td>
                            </tr>
                <%
                        }
                        connection.close();
                    } catch (Exception e) {
                %>
                    <p class="error">Error fetching students: <%= e.getMessage() %></p>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
