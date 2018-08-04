<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="/css/login.css">
    <script src="https://www.google.com/recaptcha/api.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <title>Admin Login</title>
</head>
<body class="text-center">
<form class="form-signin" method="post" action="/AdminLogin">
    <img class="mb-4" src="image/movie.svg" alt="" width="72" height="72">
    <h1 class="h3 mb-3 font-weight-normal">Admin Login</h1>
    <label for="username" class="sr-only">Username</label>
    <input type="text" name="username" id="username" class="form-control" placeholder="Username" required autofocus>
    <label for="inputPassword" class="sr-only">Password</label>
    <input type="password" name="password" id="inputPassword" class="form-control" placeholder="Password" required>
    <div class="g-recaptcha" data-sitekey="6Ld5D1oUAAAAAGkPcZ6GpeTvFA15pYZLTD6b6hTA"></div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
    <%
        String login = (String) request.getAttribute("login");
        if (login != null) {
            if (login.equals("Failed")) {
                out.println("<p class=\"mt-5 mb-3 invalid-login\">You have entered an invalid ID/Password<p>");
            } else if (login.equals("captcha")) {
                out.println("<p class=\"mt-5 mb-3 invalid-login\">Captcha Failed.<p>");
            }
        }
    %>
    <p class="mt-5 mb-3 text-muted">SPMovy &copy; 2018</p>
</form>
</body>
</html>