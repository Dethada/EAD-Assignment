<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 29/4/2018
  Time: 9:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@ page import="org.omg.CORBA.Request" %>
<%@ page import="com.spmovy.DatabaseUtils" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="css/album.css" rel="stylesheet">
    <title>SPMovy</title>


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
            <a href="index.jsp" class="navbar-brand d-flex align-items-center">

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
            <h1 class="jumbotron-heading">SPMovy</h1>
            <p class="lead text-muted">SPMovy is an online movie booking portal to allow the public to book for movie tickets online.</p>
            <form id="statusform" action="index.jsp">
                <input type="submit" class="btn btn-primary my-2" id="nowshowingbutton" value="Now Showing">
                <input type="submit" class="btn btn-secondary my-2" id="comingsoonbutton" value="Coming Soon">
            </form>
        </div>
    </section>
    <%

        DatabaseUtils db = new DatabaseUtils();

        String moviestatus = request.getParameter("status");
        if(moviestatus == null){
            moviestatus = "Now Showing";
        }
        String genreid = request.getParameter("genre");
        if(genreid == null){
            genreid = "0";
        }
        try{
        ResultSet genreset = db.executeFixedQuery("SELECT ID,name from Genre");

    %>
    <div class="album py-4 bg-light">
        <div class="container">
            <h5>Filter to your favourite genre!</h5>
            <div class="col-sm-3 mb-5 mt-3">
                <form action="index.jsp?status=Now Showing">
                    <select name="genre" onchange='this.form.submit()' class="form-control" id="exampleFormControlSelect1">
                        <option value="0" <%if(genreid.equals("0")){out.println("selected=\"selected\"");}%>>All</option>
                        <%
                            while (genreset.next()){
                                String gID = genreset.getString(1);
                                String genrename1 = genreset.getString(2);
                        %>
                        <option value ="<%=gID%>"<%if(genreid.equals(gID)){out.println("selected=\"selected\"");}%>><%=StringEscapeUtils.escapeHtml4(genrename1)%></option>
                            <%}%>
                        <%out.print("<input type=\"hidden\" name=\"status\" value=\"" + moviestatus + "\"");%>
                    </select>
                </form>
            </div>
            <%

                if (genreid.equals("0")) {
                    out.print("<h2>All Movies</h2>");
                }else{
                    String genrename = "";
                    ResultSet rs = db.executeQuery("SELECT name from Genre where ID = ?",genreid);
                    if(rs.next()){
                        genrename = rs.getString(1);
                    }
                    out.print("<h2>"+StringEscapeUtils.escapeHtml4(genrename)+" Movies</h2>");

                }
            %>
            <div class="row">
                <%
                if (genreid.equals("0")) {
                    ResultSet rs = db.executeFixedQuery("SELECT ID, title, imagepath, duration FROM movie where status=\""+moviestatus+"\"");
                    while (rs.next()) {
                %>
                <div class="col-md-4">
                    <div class="card mb-4 box-shadow">
                        <%
                            String movieID = rs.getString(1);
                            String movietitle = rs.getString(2);
                            String imagepath = rs.getString(3);
                            String duration = rs.getString(4);

                            out.print("<a href=\"moviedetails.jsp?movieid=" + movieID + "\">" + "<img class=\"card-img-top\" src=\"" + StringEscapeUtils.escapeHtml4(imagepath) + "\"/></a>");
                            out.print("<div class=\"card-body\"><p class=\"card-text\">" + StringEscapeUtils.escapeHtml4(movietitle) + "</p>");

                        %>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="btn-group">
                                <%
                                    out.print("<a class=\"btn btn-sm btn-outline-secondary\"" + "href=\"moviedetails.jsp?movieid=" + StringEscapeUtils.escapeHtml4(movieID) + "\">View</a>");%>
                            </div>
                            <small class="text-muted"><%=StringEscapeUtils.escapeHtml4(duration) + " mins"%>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
            <% }
            } else {
                ResultSet rs2 = db.executeQuery("SELECT movie.ID, movie.title, movie.imagepath, movie.duration from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID where genreID = ? and status=\""+moviestatus+"\""
                        ,genreid);
                while (rs2.next()) {
            %>
            <div class="col-md-4">
                <div class="card mb-4 box-shadow">
                    <%
                        String movieID = rs2.getString(1);
                        String movietitle = rs2.getString(2);
                        String imagepath = rs2.getString(3);
                        String duration = rs2.getString(4);

                        out.print("<a href=\"moviedetails.jsp?movieid=" + StringEscapeUtils.escapeHtml4(movieID) + "\">" + "<img class=\"card-img-top\" src=\"" + StringEscapeUtils.escapeHtml4(imagepath) + "\"/></a>");
                        out.print("<div class=\"card-body\"><p class=\"card-text\">" + StringEscapeUtils.escapeHtml4(movietitle) + "</p>");

                    %>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <%
                                out.print("<a class=\"btn btn-sm btn-outline-secondary\"" + "href=\"moviedetails.jsp?movieid=" + StringEscapeUtils.escapeHtml4(movieID) + "\">View</a>");%>
                        </div>
                        <small class="text-muted"><%=StringEscapeUtils.escapeHtml4(duration) + " mins"%>
                        </small>
                    </div>
                </div>
            </div>
            </div>
        <%
                }
            }%>

    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();

        }
        finally {
            db.closeConnection();
        }

    %>

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
<script src="js/MovieStatus.js"></script>
</body>
</html>

