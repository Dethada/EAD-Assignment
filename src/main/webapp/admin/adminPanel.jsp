<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>
<title>Admin Panel</title>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/admin/adminPanel.jsp">SPMovy Admin</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">
                    Movies
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/movies.jsp">List Movies</a>
                    <a class="dropdown-item" href="/admin/addMovie.jsp">Add Movie</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">
                    Genres
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/genres.jsp">List Genres</a>
                    <a class="dropdown-item" href="/admin/addGenre.jsp">Add Genre</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">
                    Actors
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/actors.jsp">List Actors</a>
                    <a class="dropdown-item" href="/admin/addActor.jsp">Add Actor</a>
                </div>
            </li>
        </ul>

        <div>
            <form class="form-inline my-2 my-lg-0" action="movies.jsp">
                <input class="form-control mr-sm-2" type="search" name="moviename" placeholder="Movie Title"
                       aria-label="Search">
                <button class="btn btn-outline-dark my-2 my-sm-0 mr-2" type="submit">Search</button>
                <a class="btn btn-outline-danger" href="/backend/Logout">Logout</a>
            </form>
        </div>
    </div>
</nav>
<%@ page import="java.sql.*" %>
<%@ page import="com.spmovy.DatabaseUtils" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spmovy.Utils" %>
<% DatabaseUtils db = Utils.getDatabaseUtils(response);
    ArrayList countreviewlist = new ArrayList();
    ArrayList movielist = new ArrayList();
    ArrayList countmovielist = new ArrayList();
    ArrayList datelist = new ArrayList();
    ArrayList genrelist = new ArrayList();
    ArrayList reviewdatelist = new ArrayList();
    try {
        ResultSet getreviews = db.executeFixedQuery("select count(reviewID), movieID from reviews group by movieID order by movieID asc");
        ResultSet getmovietitle = db.executeFixedQuery("select title from movie order by ID asc");
        ResultSet getmoviegenre = db.executeFixedQuery("SELECT count(movie.ID), Genre.name from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID group by Genre.name");
        ResultSet getdate = db.executeFixedQuery("select DATE(createdat) from reviews group by DATE(createdat)");
        while (getmovietitle.next()) {
            movielist.add("\"" + getmovietitle.getString(1) + "\"");
        }
        while (getreviews.next()) {
            countreviewlist.add(getreviews.getInt(1));

        }
        while (getmoviegenre.next()) {
            countmovielist.add(getmoviegenre.getInt(1));
            genrelist.add("\"" + getmoviegenre.getString(2) + "\"");
        }

        while (getdate.next()) {
            datelist.add("\"" + getdate.getString(1) + "\"");
        }
        for (int i = 0; i < datelist.size(); i++) {
            ResultSet getreviewdata = db.executeQuery("select count(reviewID) from reviews where DATE(createdat) <=" + datelist.get(i));
            while (getreviewdata.next()) {
                reviewdatelist.add(getreviewdata.getString(1));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("/errors/error.html");
    } finally {
        db.closeConnection();
    }
%>


<div class="row mt-2 px-2">
    <div class="col mr-1">
        <canvas id="myChart"></canvas>
    </div>
    <div class="col">
        <canvas id="myChart2"></canvas>
    </div>
</div>
<script>
    var ctx = document.getElementById("myChart2").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: <%=datelist%>,
            datasets: [{
                label: 'Number of reviews',
                backgroundColor: [
                    'rgba(255,255,255, 0.1)'

                ],
                borderColor: [
                    'rgba(255, 0, 0, 1)'
                ],
                data: <%=Arrays.toString(reviewdatelist.toArray())%>,
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: 'Number of reviews per day',
                fontSize: 20
            },
            tooltips: {
                mode: 'index',
                intersect: false,
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                xAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,

                    }
                }],
                yAxes: [{
                    display: true,
                    scaleLabel: {
                        display: true,

                    }
                }]
            }
        }
    });
</script>
<script>
    var ctx = document.getElementById("myChart").getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: <%=genrelist%>,
            datasets: [{
                label: 'Number of movies per genre',
                data: <%=Arrays.toString(countmovielist.toArray())%>,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)',
                    'rgba(255, 142, 230,0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(255, 142, 230,1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            legend: {
                position: 'top',
            },
            title: {
                display: true,
                text: 'Number of movies per genre',
                fontSize: 20
            },
            animation: {
                animateScale: true,
                animateRotate: true
            }
        }

    });
</script>
</body>
<%@ include file="footer.html" %>
