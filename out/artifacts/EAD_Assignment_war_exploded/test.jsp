<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 29/4/2018
  Time: 9:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" %>
<%@ page import="org.omg.CORBA.Request" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/bootstrap-4.1.0/favicon.ico">
    <link rel="stylesheet" href="styles.css">
    <title>SPMovy</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap-4.1.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="album.css" rel="stylesheet">
</head>

<body>

<header>
    <div class="collapse bg-dark" id="navbarHeader">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-md-7 py-4">
                    <h4 class="text-white">About</h4>
                    <p class="text-muted">SPMovy is an online movie booking portal to allow the public to book for movie
                        tickets online.</p>
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
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarHeader"
                    aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</header>

<main role="main">

    <section class="jumbotron text-center">
        <div class="container">
            <h1 class="jumbotron-heading">Album example</h1>
            <p class="lead text-muted">Something short and leading about the collection below—its contents, the creator,
                etc. Make it short and sweet, but not too short so folks don't simply skip over it entirely.</p>
        </div>
    </section>

    <form action="test.jsp">
        <select name="genre" onchange='this.form.submit()'>
            <option value="0">All</option>
            <option value="1">Action</option>
            <option value="2">Romance</option>
            <option value="3">Thriller</option>
            <option value="4">Comedy</option>
            <option value="5">Drama</option>
            <option value="6">War</option>
            <option value="7">Adventure</option>
        </select>
    </form>

    <div class="album py-5 bg-light">
        <div class="container">
                    <div class="row">
                        <%
                            String genreid = request.getParameter("genre");
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://52.74.214.114:3306/spmovy", "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
                                if (genreid == null){
                                    PreparedStatement showallmovies = conn.prepareStatement("SELECT ID, title, imagepath, duration FROM movie");
                                    ResultSet rs = showallmovies.executeQuery();
                                while (rs.next()) {
                        %>
                             <div class="col-md-4">
                            <div class="card mb-4 box-shadow">
                                <%
                                    String movieID = rs.getString(1);
                                    String movietitle = rs.getString(2);
                                    String imagepath = rs.getString(3);
                                    String duration = rs.getString(4);

                                    out.print("<a href=\"moviedetails.jsp?movieid=" + movieID + "\">" + "<img class=\"card-img-top\" src=\"" + imagepath + "\"/></a>");
                                    out.print("<div class=\"card-body\"><p class=\"card-text\">" + movietitle + "</p>");

                                %>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <%
                                            out.print("<a class=\"btn btn-sm btn-outline-secondary\"" + "href=\"moviedetails.jsp?movieid=" + movieID + "\">View</a>");%>
                                    </div>
                                    <small class="text-muted"><%=duration + " mins"%>
                                    </small>
                                </div>
                            </div>
                        </div>
                        </div>
            <%}%>
            <div class="row">
                    <%
                        }else if(genreid.equals("0")){
                            PreparedStatement showallmovies = conn.prepareStatement("SELECT ID, title, imagepath, duration FROM movie");
                            ResultSet rs = showallmovies.executeQuery();
                            while (rs.next()) {
                    %>
                <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                        <%
                            String movieID = rs.getString(1);
                            String movietitle = rs.getString(2);
                            String imagepath = rs.getString(3);
                            String duration = rs.getString(4);

                            out.print("<a href=\"moviedetails.jsp?movieid=" + movieID + "\">" + "<img class=\"card-img-top\" src=\"" + imagepath + "\"/></a>");
                            out.print("<div class=\"card-body\"><p class=\"card-text\">" + movietitle + "</p>");

                        %>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <%
                                    out.print("<a class=\"btn btn-sm btn-outline-secondary\"" + "href=\"moviedetails.jsp?movieid=" + movieID + "\">View</a>");%>
                            </div>
                            <small class="text-muted"><%=duration + " mins"%>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
           <% }
                }

                        else{
                        PreparedStatement filtermovies = conn.prepareStatement("SELECT movie.ID, movie.title, movie.imagepath, movie.duration from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID where genreID = ?");
                        filtermovies.setObject(1,genreid);
                        ResultSet rs2 = filtermovies.executeQuery();
                        while (rs2.next()) {
                    %>
                        <div class="col-md-4">
                        <div class="card mb-4 box-shadow">
                    <%
                        String movieID = rs2.getString(1);
                        String movietitle = rs2.getString(2);
                        String imagepath = rs2.getString(3);
                        String duration = rs2.getString(4);

                        out.print("<a href=\"moviedetails.jsp?movieid=" + movieID + "\">" + "<img class=\"card-img-top\" src=\"" + imagepath + "\"/></a>");
                        out.print("<div class=\"card-body\"><p class=\"card-text\">" + movietitle + "</p>");

                    %>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <%
                                out.print("<a class=\"btn btn-sm btn-outline-secondary\"" + "href=\"moviedetails.jsp?movieid=" + movieID + "\">View</a>");%>
                        </div>
                        <small class="text-muted"><%=duration + " mins"%>
                        </small>
                    </div>
                </div>
            </div>

            </div>
            <%}
            }%>

        </div>
                    <%
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>

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
