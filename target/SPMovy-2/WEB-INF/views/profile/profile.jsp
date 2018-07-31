<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page contentType="text/html;charset=UTF-8"%>
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
    <title>SPMovy</title>
</head>
<style>
    body {
        margin-top:50px;
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
                <li class="nav-item"><a href="#" class="nav-link">More</a></li>
            </ul>
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                <li class="nav-item order-2 order-md-1"><a href="#" class="nav-link" title="settings"><i class="fa fa-cog fa-fw fa-lg"></i></a></li>
                <li class="dropdown order-1">
                <li class="nav-item"><a href="/user/Profile" class="nav-link">Welcome, <%= "webdev" %></a></li>
            </ul>
        </div>
    </div>
</nav>

<main role="main">
    <div class="album py-4">
        <div class="container">
            <form method="post" action="/user/Profile">
                <div class="form-group row">
                    <label for="username" class="col-sm-2 col-form-label">Username</label>
                    <div class="col-md-3">
                        <input id="username" class="form-control" type="text" name="username" placeholder="Username" value="<%= user.getUsername() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="name" class="col-sm-2 col-form-label">Name</label>
                    <div class="col-md-3">
                        <input id="name" class="form-control" type="text" name="name" placeholder="Name" value="<%= user.getName() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="email" class="col-sm-2 col-form-label">Email</label>
                    <div class="col-md-3">
                        <input id="email" class="form-control" type="email" name="email" placeholder="Email" value="<%= user.getEmail() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="contact" class="col-sm-2 col-form-label">Contact</label>
                    <div class="col-md-3">
                        <input id="contact" class="form-control" type="tel" name="contact" placeholder="Contact number" value="<%= user.getContact() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <h3>Credit Card</h3>
                </div>
                <div class="form-group row">
                    <label for="cardname" class="col-sm-2 col-form-label">Full Name (on card)</label>
                    <div class="col-md-3">
                        <input id="cardname" class="form-control" type="text" name="cardname" placeholder="Full Name" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="creditcard" class="col-sm-2 col-form-label">Credit Card</label>
                    <div class="col-md-3">
                        <input id="creditcard" class="form-control" type="text" name="creditcard" placeholder="Card number" value="<%= user.getCreditcard() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="cvv" class="col-sm-2 col-form-label">CVV</label>
                    <div class="col-md-3">
                        <input id="cvv" class="form-control" type="number" name="cvv" placeholder="CVV" value="<%= user.getCvv() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <label for="exp" class="col-sm-2 col-form-label">Expiry Date</label>
                    <div class="col-md-3">
                        <input id="exp" class="form-control" type="text" name="exp" placeholder="MM/YY" value="<%= user.getExp() %>" required>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-10">
                        <button type="submit" class="btn btn-primary">Update Profile</button>
                    </div>
                </div>
            </form>
        </div>
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
<script src="js/MovieStatus.js"></script>
</body>
</html>

