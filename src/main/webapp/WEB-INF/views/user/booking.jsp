<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spmovy.beans.SeatsJB" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="com.spmovy.beans.BookingJB" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="java.util.HashSet" %>
<% UserJB user = (UserJB) session.getAttribute("user"); %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="../../../css/album.css" rel="stylesheet">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/css/jquery.seat-charts.css">
    <link rel="stylesheet" href="/css/booking.css">
    <title>Bookings</title>
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

    <%
        String bookingid = (String) request.getAttribute("bookingid");
        BookingJB bookjb = (BookingJB) session.getAttribute(bookingid);
        int qty = bookjb.getQty();
        int movieid = bookjb.getMovieID();
        String movietitle = bookjb.getMovietitle();
        String moviedate = bookjb.getSlotdate();
        String movietime = bookjb.getSlottime();
        HashSet<String> seatset = bookjb.getSeatset();
        String seatstr = "";
        if (seatset != null) {
            seatstr = String.join(",", seatset);
        }
        ArrayList<String> occupiedseatslist = new ArrayList<String>();
        ArrayList<SeatsJB> seatbeanlist = (ArrayList<SeatsJB>) request.getAttribute("seatbeanlist");
        for (SeatsJB seatbean : seatbeanlist) {
            occupiedseatslist.add("\"" + seatbean.getRow() + "_" + seatbean.getCol()+ "\"");
        }
        float seatprice = bookjb.getPrice();
    %>

<div class="wrapper">
    <div class="container">
        <h3 class="mb-2">You have selected <%=qty%> seats for <%=movietitle%> at <%=movietime%>, <%=moviedate%></h3>
        <div class="alert alert-danger" role="alert" style="display: none">
            Please select <%=qty%> tickets before checking out!
        </div>
        <div id="seat-map">
            <div class="front-indicator">SCREEN</div>

        </div>
        <div class="booking-details">
            <h2>Booking Details</h2>

            <h3> Selected Seats (<span id="counter">0</span>):</h3>
            <ul id="selected-seats"></ul>

            Total: <b>$<span id="total">0</span></b>
            <a href="/user/Checkout" id="checkout" onclick="return check()" class="btn btn-primary">Checkout &raquo;</a>
            <div id="legend"></div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
			  crossorigin="anonymous"></script>
<script src="/js/jquery.seat-charts.min.js"></script>


<script>
    var firstSeatLabel = 1;
    <% if (seatstr.isEmpty()) { %>
        var selectedseats = [];
    <% } else { %>
        var selectedseats = "<%=seatstr%>".split(",");
        if (typeof selectedseats == "string") {
            selectedseats = [selectedseats];
        }
        console.log(selectedseats);
    <% } %>
    $(document).ready(function () {
        var seatarr = [];
        for (var i = 0; i < 10; i++) {
            seatarr.push("ssssssssssssssssssss");
        }
        var $cart = $('#selected-seats'),
            $counter = $('#counter'),
            $total = $('#total'),
            sc = $('#seat-map').seatCharts({
                map: seatarr,
                seats: {

                    s: {
                        price: <%=seatprice%>,
                        classes: 'seats', //your custom CSS class
                        category: 'Seats'
                    }

                },
                naming: {
                    top: false,
                    rows: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'],
                    getLabel: function (character, row, column) {
                        if (firstSeatLabel > 20) {
                            firstSeatLabel = 1;
                        }
                        return firstSeatLabel++;

                    },
                },
                legend: {
                    node: $('#legend'),
                    items: [
                        ['s', 'available', 'Avaliable'],
                        ['s', 'selected', 'Selected'],
                        ['f', 'unavailable', 'Already Booked']
                    ]
                },
                click: function () {

                    if (this.status() == 'available') {
                        if (selectedseats.length >= <%=qty%>) {
                            return 'available';
                        }
                        else {
                            var seatno = this.settings.id;
                            seatno = seatno.replace(/[_-]/g, "");
                            //let's create a new <li> which we'll add to the cart items
                            $('<li>' + seatno + ': <b>$' + this.data().price + '</b> <a href="#" class="cancel-cart-item">[cancel]</a></li>')
                                .attr('id', 'cart-item-' + this.settings.id)
                                .data('seatId', this.settings.id)
                                .appendTo($cart);

                            $.ajax({
                                type: 'POST',
                                url: "/user/SelectSeat",
                                data: {
                                    'action': 'add',
                                    'seat': seatno,
                                    'bookingid': '<%=bookingid%>'
                                },
                                success: (msg) => { 
                                    console.log(msg);
                                },
                                error: (e) => { 
                                    console.log("ERROR : ", e);
                                    alert("Failed to add seat");
                                }
                            });
                            /*
                             * Lets update the counter and total
                             *
                             * .find function will not find the current seat, because it will change its stauts only after return
                             * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                             */
                            $total.text(parseFloat($total.text()) + this.data().price);
                            selectedseats.push(seatno);
                            $("#seatarr").val(selectedseats);
                            $counter.text(selectedseats.length);
                            return 'selected';

                        }
                    } else if (this.status() == 'selected') {
                        $.ajax({
                            type: 'POST',
                            url: "/user/SelectSeat",
                            data: {
                                'action': 'del',
                                'seat': this.settings.id.replace(/[_-]/g, ""),
                                'bookingid': '<%=bookingid%>'
                            },
                            success: (msg) => {
                                console.log(msg); 
                            },
                            error: (e) => { 
                                console.log("ERROR : ", e);
                                alert("Failed to remove seat");
                            }
                        });
                        //remove the item from our cart
                        $('#cart-item-' + this.settings.id).remove();
                        selectedseats.pop();
                        $("#seatarr").val("test");
                        //update the counter
                        $counter.text(selectedseats.length);
                        //and total
                        $total.text(parseFloat($total.text()) - this.data().price);
                        //seat has been vacated
                        return 'available';
                    } else if (this.status() == 'unavailable') {
                        //seat has been already booked
                        return 'unavailable';
                    } else {
                        return this.style();
                    }
                }

            });

        //this will handle "[cancel]" link clicks
        $('#selected-seats').on('click', '.cancel-cart-item', function () {
            //let's just trigger Click event on the appropriate seat, so we don't have to repeat the logic here
            sc.get($(this).parents('li:first').data('seatId')).click();
        });

        // some seats have already been booked
        for (var i=0;i<selectedseats.length;i++) {
            var seat = document.getElementById(selectedseats[i][0] + "_" + selectedseats[i].slice(1));
            seat.classList.remove('available');
            seat.classList.add('selected');
            $('<li>' + selectedseats[i] + ': <b>$' + <%=seatprice%> + '</b> <a href="#" class="cancel-cart-item">[cancel]</a></li>')
                .attr('id', 'cart-item-' + seat)
                .data('seatId', seat)
                .appendTo($('#selected-seats'));
            /*
            * Lets update the counter and total
            *
            * .find function will not find the current seat, because it will change its stauts only after return
            * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
            */
            $('#total').text(parseFloat($('#total').text()) + <%=seatprice%>);
        }
        $('#counter').text(selectedseats.length);
        $("#seatarr").val(selectedseats);
        // sc.get(preselectedseats).status('selected');
        sc.get(<%=occupiedseatslist%>).status('unavailable');
    });
    function check(){
        if (document.getElementById("counter").innerHTML != <%=qty%>){
            $(".alert").show();
            return false;
        } else{
            return true;
        }
    }
</script>
</body>
</html>
