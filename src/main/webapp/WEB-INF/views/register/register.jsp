<%@ page contentType="text/html;charset=UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
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
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
                <li class="dropdown order-1">
                <li class="nav-item"><a href="/Login" class="nav-link">Login</a></li>
            </ul>
        </div>
    </div>
</nav>

<main role="main">
    <div class="container">
        <% String msg = (String) request.getAttribute("message");
            String invalid = (String) request.getAttribute("failed");
        if (msg != null && invalid != null) {
            if (invalid.equals("true")) {%>
        <p class="alert alert-danger">${message}</p>
        <% } else { %>
        <p class="alert alert-success">${message}</p>
        <% }} %>
        <form method="post" action="/RegisterUser" onsubmit="return validateform()">
            <div class="form-group row">
                <label for="username" class="col-sm-2 col-form-label">Username</label>
                <div class="col-md-3">
                    <input id="username" pattern="^[A-z\d]{1,50}$" class="form-control" type="text" name="username" placeholder="Username" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="name" class="col-sm-2 col-form-label">Name</label>
                <div class="col-md-3">
                    <input id="name" pattern="^[A-z ]{1,255}$" class="form-control" type="text" name="name" placeholder="Name" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-md-3">
                    <input id="email" class="form-control" type="email" name="email" placeholder="Email" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="contact" class="col-sm-2 col-form-label">Contact</label>
                <div class="col-md-3">
                    <input id="contact" pattern="^[89]\d{7}$" class="form-control" type="tel" name="contact" placeholder="Contact number" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="pw1" class="col-sm-2 col-form-label">Password</label>
                <div class="col-md-3">
                    <input id="pw1" pattern="^(\d+[A-z]+|[A-z]+\d+)[\dA-z]*$" class="form-control" type="password" name="password" placeholder="Password" required>
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
                <h3>Credit Card</h3>
            </div>
            <div class="form-group row">
                <label for="cardname" class="col-sm-2 col-form-label">Full Name (on card)</label>
                <div class="col-md-3">
                    <input id="cardname" pattern="^[A-z ]{1,26}$" class="form-control" type="text" name="cardname" placeholder="Full Name" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="creditcard" class="col-sm-2 col-form-label">Card Number</label>
                <div class="col-md-3">
                    <input id="creditcard" pattern="^\d{14,19}$" class="form-control" type="text" name="creditcard" placeholder="Card number" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="cvv" class="col-sm-2 col-form-label">CVV</label>
                <div class="col-md-3">
                    <input id="cvv" pattern="^\d{3}$" class="form-control" type="text" name="cvv" placeholder="CVV" required>
                </div>
            </div>
            <div class="form-group row">
                <label for="exp" class="col-sm-2 col-form-label">Expiry Date</label>
                <div class="col-md-3">
                    <input id="exp" pattern="^\d{2}/\d{2}$" class="form-control" type="text" name="exp" placeholder="MM/YY" required>
                </div>
            </div>
            <%--https://bootsnipp.com/snippets/5Mkl8--%>
            <div class="form-group row">
                <div class="col-sm-10">
                    <button type="submit" class="btn btn-primary">Register</button>
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

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
        integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
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
</body>
</html>
