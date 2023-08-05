<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer List</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<header>
    <button class="add-customer-btn" onclick="location.href='customer_details.jsp'">Add Customer</button>
    Customer List
</header>
<table>
    <thead>
    <tr>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Street</th>
        <th>Address</th>
        <th>City</th>
        <th>State</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody id="customerList">
        <%
            String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
            String dbUser = "root"; // Replace with your database username
            String dbPassword = ""; // Replace with your database password

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM customers");

                while (rs.next()) {
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String street = rs.getString("street");
                    String address = rs.getString("address");
                    String city = rs.getString("city");
                    String state = rs.getString("state");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");

                    // Display the customer data in a row of the table
                    out.println("<tr>");
                    int customerId = rs.getInt("customer_id");
                    out.println("<td>" + firstName + "</td>");
                    out.println("<td>" + lastName + "</td>");
                    out.println("<td>" + street + "</td>");
                    out.println("<td>" + address + "</td>");
                    out.println("<td>" + city + "</td>");
                    out.println("<td>" + state + "</td>");
                    out.println("<td>" + email + "</td>");
                    out.println("<td>" + phone + "</td>");
                    out.println("<td>");
                    out.println("<a href='edit.jsp?id=" + customerId + "'><button>Edit</button></a>");
                    out.println("<a href='delete.jsp?id=" + customerId + "'><button>Delete</button></a>");
                    out.println("</td>");
                    out.println("</tr>");
                }

                // Close resources
                rs.close();
                stmt.close();
                conn.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        %>
    </tbody>
</table>
</body>
</html>

