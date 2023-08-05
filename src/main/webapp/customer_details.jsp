<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Customer Details</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>Add Customer Details</header>
    <form method="post">
        <input type="text" name="first_name" placeholder="First Name" required>
        <input type="text" name="last_name" placeholder="Last Name" required>
        <input type="text" name="street" placeholder="Street" required>
        <input type="text" name="address" placeholder="Address" required>
        <input type="text" name="city" placeholder="City" required>
        <input type="text" name="state" placeholder="State" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="tel" name="phone" placeholder="Phone" required>
        <input type="submit" value="Save">


        <script>
                function addCustomer() {
                    // Get the form data
                    const firstName = document.getElementsByName('first_name')[0].value;
                    const lastName = document.getElementsByName('last_name')[0].value;
                    const street = document.getElementsByName('street')[0].value;
                    const address = document.getElementsByName('address')[0].value;
                    const city = document.getElementsByName('city')[0].value;
                    const state = document.getElementsByName('state')[0].value;
                    const email = document.getElementsByName('email')[0].value;
                    const phone = document.getElementsByName('phone')[0].value;

                    // Create the JSON payload
                    const payload = {
                        "first_name": firstName,
                        "last_name": lastName,
                        "street": street,
                        "address": address,
                        "city": city,
                        "state": state,
                        "email": email,
                        "phone": phone
                    };

                    // Convert the payload to JSON string
                    const jsonPayload = JSON.stringify(payload);

                    // Perform the API request
                    fetch("https://qa2.sunbasedata.com/sunbase/portal/api/assignment.jsp", {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer dGVzdEBzdW5iYXNlZGF0YS5jb206VGVzdEAxMjM' // Replace with your actual token
                        },
                        body: jsonPayload
                    })
                    .then(response => {
                        if (response.status === 201) {
                            alert("Customer added successfully!");
                            // Redirect to the customer_list.jsp page after successful save
                            window.location.href = "customer_list.jsp";
                        } else if (response.status === 400) {
                            alert("Failed to add customer. First Name or Last Name is missing.");
                        } else {
                            alert("Error occurred while adding customer.");
                        }
                    })
                    .catch(error => {
                        alert("Error occurred while adding customer.");
                        console.error(error);
                    });

                    // Prevent form submission
                    return false;
                }
            </script>
    </form>
    <%
        if (request.getMethod().equalsIgnoreCase("post")) {
            String url = "jdbc:mysql://localhost:3306/login"; // Replace with your database URL
            String dbUser = "root"; // Replace with your database username
            String dbPassword = ""; // Replace with your database password

            // Get the customer details from the form
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
                PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO customers (first_name, last_name, street, address, city, state, email, phone) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
                );

                // Set the parameters for the prepared statement
                stmt.setString(1, firstName);
                stmt.setString(2, lastName);
                stmt.setString(3, street);
                stmt.setString(4, address);
                stmt.setString(5, city);
                stmt.setString(6, state);
                stmt.setString(7, email);
                stmt.setString(8, phone);

                // Execute the SQL query to save the customer details
                stmt.executeUpdate();

                // Close resources
                stmt.close();
                conn.close();

                // Redirect back to the customer_list.jsp page after successful save
                response.sendRedirect("customer_list.jsp");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                // Handle any errors or show an error message
            }
        }
    %>
</body>
</html>
