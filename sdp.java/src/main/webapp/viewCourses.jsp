<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Courses</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
         /* Sidebar Styling */
.sidebar {
    width: 200px;               /* Set the width of the sidebar */
    height: 100vh;              /* Set the height of the sidebar to fill the entire viewport */
    background-color: #2c3e50;  /* Set the background color to a dark blue-gray */
    color: white;               /* Set the text color to white */
    padding-top: 20px;          /* Add top padding to the sidebar */
    position: fixed;            /* Fix the sidebar's position to the left side of the screen */
}

.sidebar a {
    color: white;               /* Set the text color of links to white */
    text-decoration: none;      /* Remove underline from links */
    display: block;             /* Make links block elements to fill the sidebar's width */
    padding: 10px;              /* Add padding inside each link */
    margin: 10px 0;             /* Add vertical margin between links */
    background-color: #34495e;  /* Set the background color of each link to a dark gray */
    border-radius: 5px;         /* Add rounded corners to each link */
}

.sidebar a:hover {
    background-color: #1abc9c;  /* Change the background color of the link on hover */
}

        .container {
            margin-left: 270px;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        td {
            background-color: #f9f9f9;
        }

        .btn-container {
            text-align: center;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin: 0 10px;
        }

        .btn:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
   <div class="sidebar">
<h2 style="text-align: center; color: white;">Admin Dashboard</h2>
    <a href="adminDashboard.jsp">Dashboard</a>
    <a href="viewStudents.jsp">Students</a>
    <a href="viewCourses.jsp">Courses</a>
    <a href="addToTimetable.jsp">Schedule</a>
    <a href="login.jsp">Logout</a>
</div>

    <!-- Main Content -->
    <div class="container">
        <h2>List of Courses</h2>

        <% 
            // Database connection details
            String dbUrl = "jdbc:mysql://localhost:3306/courses";
            String dbUser = "root";
            String dbPassword = "Root";

            try {
                // Connect to the database
                Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                
                // SQL query to retrieve all courses
                String selectQuery = "SELECT course_id, course_name, duration, faculty_id, faculty_name FROM courses";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(selectQuery);
                
                // Check if there are results
                if (!rs.next()) {
                    out.println("<p class='error'>No courses available in the database!</p>");
                } else {
                    // Display courses in a table
                    out.println("<table>");
                    out.println("<tr><th>Course ID</th><th>Course Name</th><th>Duration</th><th>Faculty ID</th><th>Faculty Name</th></tr>");
                    
                    // Loop through each course and display in a row
                    do {
                        int courseId = rs.getInt("course_id");
                        String courseName = rs.getString("course_name");
                        String duration = rs.getString("duration");
                        int facultyId = rs.getInt("faculty_id");
                        String facultyName = rs.getString("faculty_name");
                        
                        out.println("<tr>");
                        out.println("<td>" + courseId + "</td>");
                        out.println("<td>" + courseName + "</td>");
                        out.println("<td>" + duration + "</td>");
                        out.println("<td>" + facultyId + "</td>");
                        out.println("<td>" + facultyName + "</td>");
                        out.println("</tr>");
                    } while (rs.next());
                    
                    out.println("</table>");
                }
                
                // Close the connection
                conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error retrieving courses: " + e.getMessage() + "</p>");
            }
        %>

        <div class="btn-container">
            <!-- Add, Update, and Remove buttons -->
            <a href="addCourse.jsp" class="btn">Add Course</a>
            <a href="updateCourse.jsp" class="btn">Update Course</a>
            <a href="removeCourse.jsp" class="btn">Remove Course</a>
        </div>
    </div>
</body>
</html>
