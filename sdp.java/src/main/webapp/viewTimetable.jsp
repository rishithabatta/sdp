<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Timetable</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #4E7E87;
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

        .content {
            margin-left: 250px;
            padding: 20px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #007BFF;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="courses.jsp">Courses</a>
        <a href="viewTimetable.jsp">Timetable</a>
        <a href="login.jsp">Logout</a>
    </div>

    <!-- Main Content -->
    <div class="content">
        <h2>Student Timetable</h2>
        <!-- Form to enter student ID -->
        <form action="viewTimetable.jsp" method="POST">
            <label for="student_id">Student ID:</label>
            <input type="text" id="student_id" name="student_id" required><br><br>
            <button type="submit">View Timetable</button>
        </form>

        <%
            String studentId = request.getParameter("student_id");
            if (studentId != null && !studentId.isEmpty()) {
                try {
                    String dbURL = "jdbc:mysql://localhost:3306/courses";
                    String dbUsername = "root";
                    String dbPassword = "Root";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                    // Modify query to include course_name from courses table
                    String sql = "SELECT t.course_id, c.course_name, t.start_time, t.end_time, t.day " +
                                 "FROM timetable t " +
                                 "JOIN courses c ON t.course_id = c.course_id " +
                                 "WHERE t.student_id = ?";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setInt(1, Integer.parseInt(studentId));
                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
        %>
                        <h3>Timetable for Student ID: <%= studentId %></h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Course ID</th>
                                    <th>Course Name</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Day</th>
                                </tr>
                            </thead>
                            <tbody>
        <%
                        do {
        %>
                                <tr>
                                    <td><%= rs.getString("course_id") %></td>
                                    <td><%= rs.getString("course_name") %></td>
                                    <td><%= rs.getString("start_time") %></td>
                                    <td><%= rs.getString("end_time") %></td>
                                    <td><%= rs.getString("day") %></td>
                                </tr>
        <%
                        } while (rs.next());
        %>
                            </tbody>
                        </table>
        <%
                    } else {
                        out.println("<p>No timetable found for student ID: " + studentId + "</p>");
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
