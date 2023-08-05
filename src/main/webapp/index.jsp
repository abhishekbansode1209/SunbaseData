<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>Login Page</header>
    <form id="loginForm" method="post">
        <input type="text" name="login_id" placeholder="Login ID" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Submit">
    </form>
    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            // Get the login credentials from the form
            String login_id = request.getParameter("login_id");
            String password = request.getParameter("password");

            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
            String dbUser = "root"; // Replace with your database username
            String dbPassword = ""; // Replace with your database password

            // Initialize the database connection and prepare the SQL query
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            String sql = "SELECT * FROM users WHERE login_id=? AND password=?";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, login_id);
                stmt.setString(2, password);
                rs = stmt.executeQuery();

                // Check if login is successful
                if (rs.next()) {
                    // If login is successful, redirect to the customer_list.jsp
                    response.sendRedirect("customer_list.jsp");
                } else {
                    // If login fails, show an error message
                    out.println("<h2>Login failed. Please check your login credentials.</h2>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                // Handle any errors or show an error message
            } finally {
                // Close resources
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
