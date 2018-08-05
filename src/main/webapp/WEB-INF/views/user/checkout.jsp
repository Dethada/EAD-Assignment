<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="com.spmovy.beans.BookingJB" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="java.util.ArrayList" %>
<% UserJB user = (UserJB) session.getAttribute("user"); %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
          <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <title>Checkout</title>
    <style>
        body {
            margin-top:100px;
        }
        .trans-btn {
            background-color: Transparent;
            background-repeat:no-repeat;
            border: none;
            cursor:pointer;
            overflow: hidden;
            outline:none;
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
            <ul class="nav navbar-nav" >
                <li class="nav-item" ><a href = "/user/Profile" class="nav-link" >Profile</a ></li >
            </ul >
            <ul class="nav navbar-nav" >
                <li class="nav-item" ><a href = "/user/Transactions" class="nav-link" >Transactions</a ></li >
            </ul >
            <ul class="nav navbar-nav" >
                <li class="nav-item" ><a href = "/user/Checkout" class="nav-link" >Checkout</a ></li >
            </ul >
            <ul class="nav navbar-nav flex-row justify-content-between ml-auto">
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
        <h2 class="mb-2">Confirm payment &amp; checkout</h2>
        <h3 class="mb-2">Booking details</h3>
        <table class="table">
            <thead class="thead-dark">
            <tr>
                <th scope="col">Movie Title</th>
                <th scope="col">Movie Date</th>
                <th scope="col">Movie Time</th>
                <th scope="col">Seat Number</th>
                <th scope="col">Remove</th>
            </tr>
            </thead>
            <tbody>
<%
    ArrayList<String> allbookingids = (ArrayList<String>) session.getAttribute("allbookingids");
    if (allbookingids != null) {
    float totalgrandtotal = 0;
    for (String bookingid: allbookingids) {
        BookingJB bookjb = (BookingJB) session.getAttribute(bookingid);
        String movietitle = bookjb.getMovietitle();
        String moviedate = bookjb.getSlotdate();
        String movietime = bookjb.getSlottime();
        float price = bookjb.getPrice();
        HashSet<String> seatset = bookjb.getSeatset();
        for (String seat: seatset) {
            totalgrandtotal += price;
%>
                <tr id="<%=seat+bookingid%>">
                <td><%=movietitle%></td>
                <td><%=moviedate%></td>
                <td><%=movietime%></td>
                <td><%=seat%></td>
                <td><i onclick="return removeSeat('<%=seat%>', '<%=bookingid%>', <%=price%>)" style="cursor: pointer;" class="fas fa-times-circle"></i></td>
                </tr>
<%  }} %>
            </tbody>
        </table>
        <p class="mb-2" style="border-bottom: solid 1px">Grand Total: <span id="grandtotal"><%=totalgrandtotal%><span></p>
        <h3 class="mt-2">Personal details</h3>
        <p class="mb-2">Name: <%=user.getName()%></p>
        <p class="mb-2">Email: <%=user.getEmail()%></p>
        <p class="mb-2">Contact Number: <%=user.getContact()%></p>
        <%
            String creditcard = user.getCreditcard();
            String replace = creditcard.substring(0,creditcard.length()-5).replaceAll(".","•");
            String lastfour = creditcard.substring(creditcard.length()-4,creditcard.length());
        %>
        <p class="mb-2">Credit Card Number (Last four digits): <%=replace%>-<%=lastfour%></p>
        <form action="/user/Checkout" method="post">
            <input type="submit" class="btn btn-primary" value="Confirm checkout">
        </form>
    </div>
<%  } else { %>
<h3 class="mt-2">You have no tickets selected.</h3>
<%  } %>
</main>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
			  crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"
        integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"
        integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm"
        crossorigin="anonymous"></script>
<script>
function removeSeat(seat, bookingid,price) {
    $.ajax({
        type: 'POST',
        url: "/user/SelectSeat",
        data: {
            'action': 'del',
            'seat': seat,
            'bookingid': bookingid
        },
        success: (msg) => {
            console.log(msg);
            document.getElementById(seat+bookingid).remove();
            var grandtotal = document.getElementById("grandtotal");
            grandtotal.innerHTML = parseFloat(grandtotal.innerHTML) - price;
        },
        error: (e) => { 
            console.log("ERROR : ", e);
            alert("Failed to remove seat");
        }
    });
}
</script>
</body>
</html>
