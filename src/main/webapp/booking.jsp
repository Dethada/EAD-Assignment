<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spmovy.beans.SeatsJB" %><%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 31-Jul-18
  Time: 7:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="com.spmovy.beans.SeatPriceJB" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="css/booking.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css"
          integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="css/album.css" rel="stylesheet">
    <link rel="shortcut icon" href="/image/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/image/favicon.ico" type="image/x-icon">
    <link href='http://fonts.googleapis.com/css?family=Lato:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="/css/jquery.seat-charts.css">
    <title>Bookings</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" role="navigation">
    <div class="container">
        <a class="navbar-brand" href="#">SPMovy</a>
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
                        <% UserJB user = (UserJB) session.getAttribute("user");
                if (user == null) { %>
                <li class="nav-item"><a href="/Login" class="nav-link">Login</a></li>
                <% } else { %>
                <li class="dropdown order-1">
                    <button type="button" id="dropdownMenu1" data-toggle="dropdown" class="btn btn-outline-secondary dropdown-toggle">Welcome, <%= user.getName() %><span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right mt-2">
                        <li class="px-3 py-2"><a href="/backend/Logout">Logout</a></li>
                    </ul>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<div class="wrapper">
    <div class="container">
        <div id="seat-map">
            <div class="front-indicator">Front</div>

        </div>
        <div class="booking-details">
            <h2>Booking Details</h2>

            <h3> Selected Seats (<span id="counter">0</span>):</h3>
            <ul id="selected-seats"></ul>

            Total: <b>$<span id="total">0</span></b>

            <button class="checkout-button">Checkout &raquo;</button>

            <div id="legend"></div>
            <%
                ArrayList<String> occupiedseatslist = new ArrayList<String>();
                ArrayList<SeatsJB> seatbeanlist = (ArrayList<SeatsJB>)request.getAttribute("seatbeanlist");
                for(SeatsJB seatbean : seatbeanlist){
                    occupiedseatslist.add("\"" + seatbean.getRow_col() + "\"");
                }
                SeatPriceJB seatpricebean = (SeatPriceJB)request.getAttribute("seatpricebean");
                double seatprice = seatpricebean.getPrice();
            %>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="/js/jquery.seat-charts.min.js"></script>

<script>
    var firstSeatLabel = 1;
    var selectedseats = [];
    $(document).ready(function() {
        var seatarr = [];
        for (var i = 0; i < 10; i++){
            seatarr.push("ssssssssss_ssssssssss");
        }
        var $cart = $('#selected-seats'),
            $counter = $('#counter'),
            $total = $('#total'),
            sc = $('#seat-map').seatCharts({
                map: seatarr,
                seats: {

                    s: {
                        price   : <%=seatprice%>,
                        classes : 'economy-class', //your custom CSS class
                        category: 'Economy Class'
                    }

                },
                naming : {
                    top : false,
                    rows : ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'],
                    getLabel : function (character, row, column) {
                        if (firstSeatLabel > 20){
                            firstSeatLabel = 1;
                        }
                        return firstSeatLabel++;

                    },
                },
                legend : {
                    node : $('#legend'),
                    items : [
                        [ 's', 'available',   'Avaliable'],
                        [ 's', 'selected',   'Selected'],
                        [ 'f', 'unavailable', 'Already Booked']
                    ]
                },
                click: function () {
                    if (this.status() == 'available') {
                        var seatno = this.settings.id;
                        seatno = seatno.replace(/[_-]/g, "");
                        //let's create a new <li> which we'll add to the cart items
                        $('<li>'+seatno+': <b>$'+this.data().price+'</b> <a href="#" class="cancel-cart-item">[cancel]</a></li>')
                            .attr('id', 'cart-item-'+this.settings.id)
                            .data('seatId', this.settings.id)
                            .appendTo($cart);
                        /*
                         * Lets update the counter and total
                         *
                         * .find function will not find the current seat, because it will change its stauts only after return
                         * 'selected'. This is why we have to add 1 to the length and the current seat price to the total.
                         */
                        $counter.text(sc.find('selected').length+1);
                        $total.text(recalculateTotal(sc)+this.data().price);
                        selectedseats.push(seatno);
                        return 'selected';
                    } else if (this.status() == 'selected') {
                        //update the counter
                        $counter.text(sc.find('selected').length-1);
                        //and total
                        $total.text(recalculateTotal(sc)-this.data().price);

                        //remove the item from our cart
                        $('#cart-item-'+this.settings.id).remove();
                        selectedseats.pop();
                        console.log(selectedseats);
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
        sc.get(<%=occupiedseatslist%>).status('unavailable');

    });

    function recalculateTotal(sc) {
        var total = 0;
        //basically find every selected seat and sum its price
        sc.find('selected').each(function () {
            total += this.data().price;
        });
        return total;
    }
</script>
</body>
</html>
