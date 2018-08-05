<%@ page contentType="text/html;charset=UTF-8" import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="com.spmovy.beans.MovieJB" %>
<%@ page import="java.util.ArrayList" %>
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
    <link href="css/album.css" rel="stylesheet">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <title>SPMovy</title>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="/">SPMovy</a>
        <button class="navbar-toggler border-0" type="button" data-toggle="collapse" data-target="#exCollapsingNavbar">
            &#9776;
        </button>
        <div class="collapse navbar-collapse" id="exCollapsingNavbar">
            <% if (user != null) { %>
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Profile" class="nav-link">Profile</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Transactions" class="nav-link">Transactions</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="nav-item"><a href="/user/Checkout" class="nav-link">Checkout</a></li>
            </ul>
            <% } %>
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                <li class="dropdown order-1">
                        <% if (user == null) { %>
                <li class="nav-item"><a href="/Login" class="nav-link">Login</a></li>
                <% } else { %>
                <li class="dropdown order-1">
                    <button type="button" id="dropdownMenu1" data-toggle="dropdown"
                            class="btn btn-outline-secondary dropdown-toggle">
                        Welcome, <%= StringEscapeUtils.escapeHtml4(user.getName()) %><span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-right mt-2">
                        <li class="px-3 py-2"><a href="/backend/Logout">Logout</a></li>
                    </ul>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<main role="main">

    <section class="jumbotron text-center">
        <div class="container">
            <h1 class="jumbotron-heading">SPMovy</h1>
            <p class="lead text-muted">SPMovy is an online movie booking portal to allow the public to book for movie
                tickets online.</p>
        </div>
    </section>
    <div class="album py-4 bg-light">
        <div class="container">
            <h5>Find movies!</h5>
            <div>
                <form action="" method="get">
                    <div class="form-group row">
                        <div class="col-md-3">
                            <select name="target" class="form-control">
                                <option value="title">Title</option>
                                <option value="genre">Genre</option>
                                <option value="actor">Actor</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <input name="query" class="form-control" type="text" requried>
                        </div>
                        <div class="col-md-3">
                            <button type="submit" class="btn btn-primary">Search</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="row">
                <%
                    ArrayList<MovieJB> movielist = (ArrayList<MovieJB>) request.getAttribute("movielist");
                    for (MovieJB movie : movielist) {
                %>
                <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                        <a href="moviedetails?movieid=<%= movie.getID() %>"><img class="card-img-top"
                                                                                 src="<%= StringEscapeUtils.escapeHtml4(movie.getImagepath()) %>"/></a>
                        <div class="card-body"><p
                                class="card-text"><%= StringEscapeUtils.escapeHtml4(movie.getTitle()) %>
                        </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="btn-group">
                                    <a class="btn btn-sm btn-outline-secondar"
                                       href="/moviedetails?movieid=<%= movie.getID() %>">View</a>
                                </div>
                                <small class="text-muted">Rating <%= movie.getRating() %>/5</small>
                                <small class="text-muted"><%= movie.getDuration() %> mins</small>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
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

