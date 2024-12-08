<%@ page import="java.sql.*,javax.servlet.*,javax.servlet.http.*" %>
<html>
<head>
    <title>Student Details</title>
</head>
<body>
    <h2>Student Details</h2>

    <%
        // Get the username from the request parameter
        String username = request.getParameter("username");

        // Debugging: Print received username
        out.println("<p>Received Username: " + username + "</p>");

        if (username != null && !username.trim().isEmpty()) {
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

                // Query to get student details based on username
                String sql = "SELECT * FROM students WHERE username=?";
                pst = con.prepareStatement(sql);
                pst.setString(1, username);
                rs = pst.executeQuery();

                // If student is found
                if (rs.next()) {
                    String student_id = rs.getString("student_id");
                    String fullName = rs.getString("student_name");
                    String email = rs.getString("email");
                    String phoneNumber = rs.getString("phonenumber");
                    String age = rs.getString("age");

                    // Display student details
                    out.println("<p><strong>Student ID:</strong> " + student_id + "</p>");
                    out.println("<p><strong>Name:</strong> " + fullName + "</p>");
                    out.println("<p><strong>Email:</strong> " + email + "</p>");
                    out.println("<p><strong>Username:</strong> " + username + "</p>");
                    out.println("<p><strong>Age:</strong> " + age + "</p>");
                    out.println("<p><strong>Phone Number:</strong> " + phoneNumber + "</p>");
                } else {
                    // If no student is found
                    out.println("<p style='color: red;'>No student found with this username.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color: red;'>Database error: " + e.getMessage() + "</p>");
            } finally {
                // Close all database resources
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            // If username is invalid or missing
            out.println("<p style='color: red;'>Invalid or missing username.</p>");
        }
    %>
</body>
</html>
