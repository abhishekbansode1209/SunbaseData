<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Customer</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>Edit Customer</header>
    <form id="editForm" method="post" action="update.jsp">
        <%
            String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
            String dbUser = "root"; // Replace with your database username
            String dbPassword = ""; // Replace with your database password

            String customerId = request.getParameter("id");
            String firstName = "";
            String lastName = "";
            String street = "";
            String address = "";
            String city = "";
            String state = "";
            String email = "";
            String phone = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customers WHERE customer_id=?");
                stmt.setString(1, customerId);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    firstName = rs.getString("first_name");
                    lastName = rs.getString("last_name");
                    street = rs.getString("street");
                    address = rs.getString("address");
                    city = rs.getString("city");
                    state = rs.getString("state");
                    email = rs.getString("email");
                    phone = rs.getString("phone");
                }

                // Close resources
                rs.close();
                stmt.close();
                conn.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        %>
        <input type="hidden" name="customer_id" value="<%= customerId %>">
        <input type="text" name="first_name" placeholder="First Name" value="<%= firstName %>" required>
        <input type="text" name="last_name" placeholder="Last Name" value="<%= lastName %>" required>
        <input type="text" name="street" placeholder="Street" value="<%= street %>" required>
        <input type="text" name="address" placeholder="Address" value="<%= address %>" required>
        <input type="text" name="city" placeholder="City" value="<%= city %>" required>
        <input type="text" name="state" placeholder="State" value="<%= state %>" required>
        <input type="email" name="email" placeholder="Email" value="<%= email %>" required>
        <input type="tel" name="phone" placeholder="Phone" value="<%= phone %>" required>
        <input type="submit" value="Update" onclick="return confirmUpdate();">
    </form>

    <script>
        function confirmUpdate() {
            // Show a confirmation popup to the user
            if (confirm("Are you sure you want to update this customer?")) {
                // If the user confirms the update, submit the form
                return true;
            } else {
                // If the user cancels the update, do not submit the form
                return false;
            }
        }
    </script>
</body>
</html>
