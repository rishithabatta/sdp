<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule Date and Time</title>
</head>
<body>
    <h2>Schedule Date and Time</h2>

    <!-- Form for Scheduling -->
    <form method="POST" action="schedule.jsp">
        <label for="studentId">Student ID: </label>
        <input type="text" id="studentId" name="studentId" required><br><br>

        <label for="studentName">Student Name: </label>
        <input type="text" id="studentName" name="studentName" required><br><br>

        <label for="facultyId">Faculty ID: </label>
        <input type="text" id="facultyId" name="facultyId" required><br><br>

        <label for="facultyName">Faculty Name: </label>
        <input type="text" id="facultyName" name="facultyName" required><br><br>

        <label for="scheduleTime">Schedule Time: </label>
        <input type="datetime-local" id="scheduleTime" name="scheduleTime" required><br><br>

        <button type="submit">Schedule</button>
    </form>

    <%
        Connection conn = null;
        PreparedStatement stmt = null;

        String dbURL = "jdbc:mysql://localhost:3306/courses";
        String dbUser = "root";
        String dbPassword = "Root";

        try {
            // Connect to the database
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Handle form submission
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                String studentName = request.getParameter("studentName");
                int facultyId = Integer.parseInt(request.getParameter("facultyId"));
                String facultyName = request.getParameter("facultyName");
                String scheduleTime = request.getParameter("scheduleTime");

                // Insert or update student record
                String insertStudentQuery = "INSERT INTO students (student_id, student_name) VALUES (?, ?) " +
                                            "ON DUPLICATE KEY UPDATE student_name = VALUES(student_name)";
                stmt = conn.prepareStatement(insertStudentQuery);
                stmt.setInt(1, studentId);
                stmt.setString(2, studentName);
                stmt.executeUpdate();

                // Insert or update faculty record
                String insertFacultyQuery = "INSERT INTO faculty (faculty_id, faculty_name) VALUES (?, ?) " +
                                            "ON DUPLICATE KEY UPDATE faculty_name = VALUES(faculty_name)";
                stmt = conn.prepareStatement(insertFacultyQuery);
                stmt.setInt(1, facultyId);
                stmt.setString(2, facultyName);
                stmt.executeUpdate();

                // Insert or update schedule record
                String insertScheduleQuery = "INSERT INTO schedule (student_id, faculty_id, schedule_time) VALUES (?, ?, ?) " +
                                             "ON DUPLICATE KEY UPDATE schedule_time = VALUES(schedule_time)";
                stmt = conn.prepareStatement(insertScheduleQuery);
                stmt.setInt(1, studentId);
                stmt.setInt(2, facultyId);
                stmt.setString(3, scheduleTime);
                stmt.executeUpdate();

                out.println("<p>Schedule added/updated successfully!</p>");
            }
        } catch (SQLException e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <!-- Button to View Schedule -->
    <form action="viewSchedule.jsp" method="GET">
        <button type="submit">View Schedule</button>
    </form>

    <br>
    <a href="adminDashboard.jsp">Back to Admin Dashboard</a>
</body>
</html>
