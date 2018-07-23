<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<form method="post" action="/backend/RegisterUser">
    <label for="username">Username</label>
    <input type="text" placeholder="Username" id="username" name="username" required>
    <label for="name">Name</label>
    <input type="text" placeholder="Name" id="name" name="name" required>
    <label for="email">Email</label>
    <input type="email" placeholder="Email" id="email" name="email" required>
    <label for="contact">Contact</label>
    <input type="tel" placeholder="Contact" id="contact" name="contact" required>
    <label for="creditcard">Credit Card</label>
    <input type="text" placeholder="Card Number" id="creditcard" name="creditcard" required>
    <label for="password">Password</label>
    <input type="password" placeholder="Password" id="password" name="password" required>
    <input type="submit" value="Submit">
</form>
</body>
</html>
