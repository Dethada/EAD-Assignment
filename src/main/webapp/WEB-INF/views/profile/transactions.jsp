<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="com.spmovy.beans.UserTransactionJB" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>
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
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <title>SPMovy | Transactions</title>
</head>
<style>
    body {
        margin-top: 100px;
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
    <h2>Transactions</h2>
    <table class="table" style="table-layout: fixed;">
        <thead class="thead-dark">
        <tr>
            <th style="word-wrap: break-word;" scope="col">Transaction ID</th>
            <th style="word-wrap: break-word;" scope="col">Transaction Time</th>
            <th style="word-wrap: break-word; " scope="col">Ticket ID</th>
            <th style="word-wrap: break-word; " scope="col">Price</th>
            <th style="word-wrap: break-word; " scope="col">Seat</th>
            <th style="word-wrap: break-word; " scope="col">Movie Time</th>
            <th style="word-wrap: break-word; " scope="col">Movie Title</th>
        </tr>
        </thead>
        <tbody>
        <%
            ArrayList<UserTransactionJB> transactionlist = (ArrayList<UserTransactionJB>) request.getAttribute("transactionlist");
            for (UserTransactionJB transaction : transactionlist) {
        %>
        <tr>
            <td style="word-wrap: break-word; "><%= transaction.getID() %>
            </td>
            <td style="word-wrap: break-word; "><%= transaction.getAt() %>
            </td style="word-wrap: break-word
            ; " >
            <td style="word-wrap: break-word; "><%= transaction.getTicketID() %>
            </td>
            <td style="word-wrap: break-word; "><%= transaction.getPrice() %>
            </td>
            <td style="word-wrap: break-word; "><%= transaction.getHall_row() + transaction.getHall_column() %>
            </td>
            <td style="word-wrap: break-word; "><%= transaction.getMoviedate() + " " + transaction.getMovietime() %>
            </td>
            <td style="word-wrap: break-word; "><%= StringEscapeUtils.escapeHtml4(transaction.getMovietitle()) %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</main>

<footer class="text-muted">
    <div class="container">

        <p class="float-right">
            <a href="#">Back to top</a>
        </p>
        <p>SPMovy &copy; 2018</p>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
        integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
</body>
</html>