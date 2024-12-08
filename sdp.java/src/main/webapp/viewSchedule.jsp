<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Scheduled Students</title>
</head>
<body>
    <h2>View Scheduled Students</h2>

    <table border="1">
        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Faculty ID</th>
            <th>Faculty Name</th>
            <th>Schedule Time</th>
        </tr>

        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            String dbURL = "jdbc:mysql://localhost:3306/courses";
            String dbUser = "root";
            String dbPassword = "Root";

            try {
                // Connect to the database
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Ensure the correct table and column names in the query
                String selectQuery = "SELECT sch.student_id, s.student_name, sch.faculty_id, f.faculty_name, sch.schedule_time " +
                                     "FROM schedule sch " +
                                     "LEFT JOIN students s ON sch.student_id = s.student_id " +
                                     "LEFT JOIN faculty f ON sch.faculty_id = f.faculty_id";
                stmt = conn.prepareStatement(selectQuery);
                rs = stmt.executeQuery();

                // Display fetched data
                while (rs.next()) {
                    int studentId = rs.getInt("student_id");
                    String studentName = rs.getString("student_name") != null ? rs.getString("student_name") : "N/A";
                    int facultyId = rs.getInt("faculty_id");
                    String facultyName = rs.getString("faculty_name") != null ? rs.getString("faculty_name") : "N/A";
                    String scheduleTime = rs.getString("schedule_time");
        %>
        <tr>
            <td><%= studentId %></td>
            <td><%= studentName %></td>
            <td><%= facultyId %></td>
            <td><%= facultyName %></td>
            <td><%= scheduleTime %></td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        %>
    </table>

    <br>
    <a href="schedule.jsp">Back to Schedule Page</a>
</body>
</html>
