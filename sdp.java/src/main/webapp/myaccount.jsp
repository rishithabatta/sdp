<%@ page import="java.sql.*, java.util.*, javax.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
</head>
<body>
    <h2>Login</h2>
    <form method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        
        <button type="submit">Login</button>
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                // Database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses", "root", "Root");

                // SQL Query to check if the user exists
                String sql = "SELECT * FROM students WHERE username = ? AND password = ?";
                ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);

                rs = ps.executeQuery();

                // Check if the user is found
                if (rs.next()) {
                    // User found, redirect to the dashboard
                    out.println("<script>alert('Login successful!'); window.location='dashboard.jsp';</script>");
                } else {
                    // No user found, show error message
                    out.println("<script>alert('No user found with the provided username and password.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
