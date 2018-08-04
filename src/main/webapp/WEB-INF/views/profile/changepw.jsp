<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<% UserJB user = (UserJB) session.getAttribute("user"); %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous" defer></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous" defer></script>
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <title>SPMovy | Change Password</title>
</head>
<style>
    body {
        margin-top:100px;
    }
</style>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="/">SPMovy</a>
        <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
            &#9776;
        </button>
        <div class="collapse navbar-collapse" id="exCollapsingNavbar">
            <% if (user != null) { %>
            <ul class="nav navbar-nav" >
                <li class="nav-item" ><a href = "/user/Profile" class="nav-link" >Profile</a ></li >
            </ul >
            <% } %>
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                <li class="nav-item order-2 order-md-1"><a href="#" class="nav-link" title="settings"><i class="fa fa-cog fa-fw fa-lg"></i></a></li>
                <li class="dropdown order-1">
                <li class="dropdown order-1">
                    <button type="button" id="dropdownMenu1" data-toggle="dropdown" class="btn btn-outline-secondary dropdown-toggle">Welcome, <%= StringEscapeUtils.escapeHtml4(user.getName()) %><span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right mt-2">
                        <li class="px-3 py-2"><a href="/backend/Logout">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<main role="main">
    <div class="container">
        <%
        String result = (String) request.getAttribute("result");
        if (result != null) {
            if (result.equals("failed")) { %>
        <p class="alert alert-danger">${message}</p>
        <% } else if (result.equals("success")) { %>
        <p class="alert alert-success">${message}</p>
        <% }} %>
        <form id="changepw" method="post" action="/user/ChangePassword" onsubmit="return validateform()">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Current Password</label>
                <div class="col-md-3">
                    <input class="form-control" type="password" name="currentpass" placeholder="Old password" required>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">New Password</label>
                <div class="col-md-3">
                    <input id="pw1" pattern="^(\d+[A-z]+|[A-z]+\d+)[\dA-z]*$" class="form-control" type="password" name="newpass" placeholder="New password" required>
                    <div class="invalid-feedback">Does not meet password requirement of 8 to 16 chars and alphanumeric.</div>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Confirm Password</label>
                <div class="col-md-3">
                    <input id="pw2" pattern="^(\d+[A-z]+|[A-z]+\d+)[\dA-z]*$" class="form-control" type="password" placeholder="Confirm password" required>
                    <div class="invalid-feedback">Passwords do not match.</div>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Change Password</button>
                </div>
            </div>
        </form>
    </div>
</main>

<footer class="text-muted">
    <div class="container">

        <p class="float-right">
            <a href="#">Back to top</a>
        </p>
        <p>SPMovy &copy; 2018</p>
    </div>
</footer>
</body>
<script>
    function validateform() {
        var pw1 = document.getElementById('pw1').value;
        var pw2 = document.getElementById('pw2').value;
        if (pw1.length < 8 || pw1.length > 16) {
            document.getElementById('pw1').className += " is-invalid";
            return false;
        } else if (pw1 !== pw2) {
            document.getElementById('pw2').className += " is-invalid";
            return false;
        }
        return true;
    }

</script>
</html>