<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login</title>
</head>
<body class="text-center">
<form class="form-signin" method="post" action="/backend/Login">
    <img class="mb-4" src="https://getbootstrap.com/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
    <label for="username" class="sr-only">Username</label>
    <input type="text" name="username" id="username" class="form-control" placeholder="Username" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    <%
        String login = request.getParameter("login");
        if (login != null) {
            if (login.equals("Failed")) {
                out.println("<p class=\"mt-5 mb-3 invalid-login\">You have entered an invalid ID/Password<p>");
            } else if (login.equals("Not")) {
                out.println("<p class=\"mt-5 mb-3 invalid-login\">Not logged in.<p>");
            }
        }
    %>
    <p class="mt-5 mb-3 text-muted">&copy; 2018</p>
</form>
</body>
</html>