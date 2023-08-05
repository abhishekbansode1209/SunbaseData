<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>Update Customer</header>
    <%
        String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
        String dbUser = "root"; // Replace with your database username
        String dbPassword = ""; // Replace with your database password

        String customerId = request.getParameter("customer_id");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String street = request.getParameter("street");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement("UPDATE customers SET first_name=?, last_name=?, street=?, address=?, city=?, state=?, email=?, phone=? WHERE customer_id=?");
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, street);
            stmt.setString(4, address);
            stmt.setString(5, city);
            stmt.setString(6, state);
            stmt.setString(7, email);
            stmt.setString(8, phone);
            stmt.setString(9, customerId);

            int rowsAffected = stmt.executeUpdate();
            stmt.close();
            conn.close();

            if (rowsAffected > 0) {
                out.println("<p>Customer data updated successfully!</p>");
                // Redirect to customer_list.jsp after successful update
                response.sendRedirect("customer_list.jsp");
            } else {
                out.println("<p>Failed to update customer data. Please try again.</p>");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<p>An error occurred while updating customer data. Please try again.</p>");
        }
    %>
    <a href="customer_details.jsp">Go Back to Customer Details</a>
</body>
</html>
