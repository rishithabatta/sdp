<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Course</title>
</head>
<body>
    <h2>Register for a Course</h2>
    <form method="post">
        <label for="course_id">Course ID:</label>
        <input type="number" name="course_id" required><br><br>
        <input type="submit" value="Register">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = (String) session.getAttribute("username"); // Assume username is stored in session
            int course_id = Integer.parseInt(request.getParameter("course_id"));

            Connection conn = null;
            PreparedStatement pst1 = null, pst2 = null;

            try {
                String url = "jdbc:mysql://localhost:3306/courses";
                String dbUser = "root";
                String dbPassword = "Root";

                // Establish connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Insert into registrations
                String sql1 = "INSERT INTO registrations (username, course_id) VALUES (?, ?)";
                pst1 = conn.prepareStatement(sql1);
                pst1.setString(1, username);
                pst1.setInt(2, course_id);
                pst1.executeUpdate();

                // Automatically create timetable entry
                String sql2 = "INSERT INTO timetable (username, course_id, day, start_time, end_time) " +
                              "VALUES (?, ?, 'Monday', '10:00:00', '12:00:00')"; // Example day and time
                pst2 = conn.prepareStatement(sql2);
                pst2.setString(1, username);
                pst2.setInt(2, course_id);
                pst2.executeUpdate();

                out.println("<p>Course registered and timetable created successfully!</p>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pst1 != null) pst1.close();
                    if (pst2 != null) pst2.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
