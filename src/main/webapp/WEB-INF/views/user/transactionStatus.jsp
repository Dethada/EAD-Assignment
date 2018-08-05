<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<% UserJB user = (UserJB) session.getAttribute("user"); %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <title>SPMovy | Status</title>
    <style>
        body {
            margin-top: 100px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="/">SPMovy</a>
        <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
            &#9776;
        </button>
        <div class="collapse navbar-collapse" id="exCollapsingNavbar">
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Profile" class="nav-link">Profile</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Transactions" class="nav-link">Transactions</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Checkout" class="nav-link">Checkout</a></li>
            </ul>
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                <li class="dropdown order-1">
                <li class="dropdown order-1">
                    <button type="button" id="dropdownMenu1" data-toggle="dropdown"
                            class="btn btn-outline-secondary dropdown-toggle">
                        Welcome, <%= StringEscapeUtils.escapeHtml4(user.getName()) %><span class="caret"></span>
                    </button>
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
        <% String msg = (String) request.getAttribute("message");
            String status = (String) request.getAttribute("status");
            if (msg != null && status != null) {
                if (status.equals("failed")) {%>
        <p class="alert alert-danger"><%=msg%>
        </p>
        <% } else { %>
        <p class="alert alert-success"><%=msg%>
        </p>
        <% }
        } %>

        <a href="/user/Transactions" class="btn btn-info">View Transactions</a>
    </div>
</main>

</body>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
</html>
