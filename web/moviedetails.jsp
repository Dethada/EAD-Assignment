<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 29/4/2018
  Time: 3:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/bootstrap-4.1.0/favicon.ico">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="album.css" rel="stylesheet">
    <title>Title</title>
</head>
<body>
<header>
<div class="collapse bg-dark" id="navbarHeader">
    <div class="container">
        <div class="row">
            <div class="col-sm-8 col-md-7 py-4">
                <h4 class="text-white">About</h4>
                <p class="text-muted">SPMovy is an online movie booking portal to allow the public to book for movie tickets online.</p>
            </div>
            <div class="col-sm-4 offset-md-1 py-4">
                <h4 class="text-white">Contact</h4>
                <ul class="list-unstyled">
                    <li><a href="https://twitter.com" class="text-white">Follow on Twitter</a></li>
                    <li><a href="https://facebook.com" class="text-white">Like on Facebook</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="navbar navbar-dark bg-dark box-shadow">
    <div class="container d-flex justify-content-between">
        <a href="#" class="navbar-brand d-flex align-items-center">

            <strong>SPMovy</strong>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</div>
</header>
<main role="main">
<div class="album py-5 bg-light">
<div class="container">
<%
    Class.forName("com.mysql.jdbc.Driver");
    String movieID = request.getParameter("movieid");
    Connection conn = DriverManager.getConnection("jdbc:mysql://52.74.214.114:3306/spmovy","spmovy","15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
    PreparedStatement showmoviedetails = conn.prepareStatement("SELECT title, synopsis, date_format(releasedate,'%e/%m/%Y'), duration, imagepath FROM  movie where movie.ID = ?");
    showmoviedetails.setObject(1, movieID);
    ResultSet rs = showmoviedetails.executeQuery();

    String synopsis = "";
    String duration = "";
    String releasedate = "";
    if(rs.next()){
        String movietitle = rs.getString(1);
        synopsis = rs.getString(2);
        releasedate = rs.getString(3);
        duration = rs.getString(4);
        String imagepath = rs.getString(5);

        out.print("<h1 style=\"padding-bottom: 10px;border-bottom: 1px solid  #b2b2b2;\">"+movietitle+"</h1>");
        out.print("<div class=\"row\"><div class=\"col-md-5\"><img src=\"" + imagepath + "\"/></div>");

    }

    PreparedStatement showactors = conn.prepareStatement("SELECT actor.name from MovieActor inner join movie on MovieActor.movieID = movie.ID inner join actor on MovieActor.actorID = actor.ID where movie.id = ?");
    showactors.setObject(1, movieID);
    ArrayList actorlist = new ArrayList();
    ResultSet rs2 = showactors.executeQuery();

    while(rs2.next()){
        actorlist.add(rs2.getString(1));

    }
    String actor = actorlist.toString();
    actor = actor.replaceAll("[\\[\\]]", "");

    PreparedStatement showgenre = conn.prepareStatement("select Genre.name from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID where movie.id=?");
    showgenre.setObject(1,movieID);
    ArrayList genrelist = new ArrayList();
    ResultSet rs3 = showgenre.executeQuery();
    while(rs3.next()){
        genrelist.add(rs3.getString(1));

    }
    String genre = genrelist.toString();
    genre = genre.replaceAll("[\\[\\]]", "");

    out.print("<div class=\"col-md-6\"><h3>Movie Details</h3>");
    out.print("<div class=\"col-md\"><h4>Cast</h4><p>"+actor+"</p></div>");
    out.print("<div class=\"col-md\"><h4>Duration</h4><p>"+duration+" mins</p></div>");
    out.print("<div class=\"col-md\"><h4>Genre</h4><p>"+genre+"</p></div>");
    out.print("<div class=\"col-md\"><h4>Release Date</h4><p>"+releasedate+"</p></div>");

    out.print("<h3>Synopsis</h3>");
    out.print("<div class=\"col-md\"<p>"+synopsis+"</p></div></div></div>");



%>
    <div class="row"><h2 style="margin-top: 20px;">SHOWTIMES</h2></div>
</div>
</div>
</main>
<footer class="text-muted">
    <div class="container">

        <p class="float-right">
            <a href="#">Back to top</a>
        </p>
        <p>Singapore Polytechnic &copy; 2018</p>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
</body>
</html>
