<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
    String dbUser = "root"; // Replace with your database username
    String dbPassword = ""; // Replace with your database password

    String customerId = request.getParameter("id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
        PreparedStatement stmt = conn.prepareStatement("DELETE FROM customers WHERE customer_id=?");
        stmt.setString(1, customerId);
        stmt.executeUpdate();

        // Close resources
        stmt.close();
        conn.close();

        // Redirect back to the customer_list.jsp page after successful delete
        response.sendRedirect("customer_list.jsp");
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        // Handle any errors or show an error message
    }
%>
