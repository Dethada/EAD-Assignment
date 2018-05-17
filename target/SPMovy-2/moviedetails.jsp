<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" import="org.apache.commons.lang3.StringEscapeUtils"%>
<%@ page import="com.spmovy.DatabaseUtils" %>
<%@ page import="com.spmovy.Utils" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="https://stackpath.bootstrapcdn.com/bootstrap-4.1.0/favicon.ico">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <link href="css/album.css" rel="stylesheet">
    <link href="css/fontawesome-stars.css" rel="stylesheet">
    <link href="css/fontawesome-stars-o.css" rel="stylesheet">

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
        <a href="index.jsp" class="navbar-brand d-flex align-items-center">
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
    <div>
<%
    int movieID;
    try {
        movieID = Integer.parseInt(request.getParameter("movieid"));
    } catch (NumberFormatException e) {
        response.sendRedirect("/index.jsp");
        return;
    }
    DatabaseUtils db = Utils.getDatabaseUtils(response);
    if (db == null) return;
    String synopsis = "";
    int duration = 0;
    String releasedate = "";
    String movietitle = "";
    String moviestatus = "";
    ResultSet rs;
    try {
        rs = db.executeQuery("SELECT title, synopsis, date_format(releasedate,'%e/%m/%Y'), duration, imagepath, status FROM  movie where movie.ID = ?",
                movieID);
        if (rs.next()) {
            movietitle = rs.getString(1);
            synopsis = rs.getString(2);
            releasedate = rs.getString(3);
            duration = rs.getInt(4);
            String imagepath = rs.getString(5);
            moviestatus = rs.getString(6);
            out.print("<a class=\"btn btn-primary mb-3\" href=\"index.jsp?status=" + StringEscapeUtils.escapeHtml4(moviestatus) + "\">Back To Home Page</a>");
            out.print("<h1 style=\"padding-bottom: 10px;border-bottom: 1px solid  #b2b2b2;\">" + StringEscapeUtils.escapeHtml4(movietitle) + "</h1>");
            out.print("<div class=\"row\"><div class=\"col-md-5\"><img src=\"" + StringEscapeUtils.escapeHtml4(imagepath) + "\"/></div>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("/errors/error.html");
        return;
    }

    ArrayList actorlist = new ArrayList();
    rs = db.executeQuery("SELECT actor.name from MovieActor inner join movie on MovieActor.movieID = movie.ID inner join actor on MovieActor.actorID = actor.ID where movie.id = ?"
            ,movieID);

    while(rs.next()){
        actorlist.add(rs.getString(1));
    }
    String actor = actorlist.toString();
    actor = actor.replaceAll("[\\[\\]]", "");

    ArrayList genrelist = new ArrayList();
    rs = db.executeQuery("select Genre.name from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID where movie.id=?"
            ,movieID);
    while(rs.next()){
        genrelist.add(rs.getString(1));

    }
    String genre = genrelist.toString();
    genre = genre.replaceAll("[\\[\\]]", "");

    out.print("<div class=\"col-md-6\"><h3>Movie Details</h3>");
    out.print("<div class=\"col-md\"><h4>Cast</h4><p>"+StringEscapeUtils.escapeHtml4(actor)+"</p></div>");
    out.print("<div class=\"col-md\"><h4>Duration</h4><p>"+duration+" mins</p></div>");
    out.print("<div class=\"col-md\"><h4>Genre</h4><p>"+StringEscapeUtils.escapeHtml4(genre)+"</p></div>");
    out.print("<div class=\"col-md\"><h4>Release Date</h4><p>"+StringEscapeUtils.escapeHtml4(releasedate)+"</p></div>");

    out.print("<h3>Synopsis</h3>");
    out.print("<div class=\"col-md\"<p>"+StringEscapeUtils.escapeHtml4(synopsis)+"</p></div></div></div>");



%>
</div>
        <div>
        <h3 class="mt-3 mb-2" style="border-bottom: #b8b8b8 1px solid">SHOWTIMES</h3>
            <%
                if(moviestatus.equalsIgnoreCase("Coming soon")){
                    out.print("<h5>Sorry this movie has not been released yet.");
                }
                else{
            %>
        <h5 class="pb-1">Select time slot for <%=StringEscapeUtils.escapeHtml4(movietitle)%></h5>
     <%
         ArrayList datelist = new ArrayList();
         ResultSet dateslotset = db.executeQuery("SELECT distinct moviedate, date_format(moviedate,\"%d/%c/%Y, %W\") from timeslot where movieID = ? order by  moviedate asc"
                 ,movieID);
         ArrayList formatteddatelist = new ArrayList();
         while (dateslotset.next()){
             datelist.add(dateslotset.getString(1));
             formatteddatelist.add(dateslotset.getString(2));

         }
         for(int i =0;i<datelist.size();i++){
             ResultSet timeslotset = db.executeQuery("SELECT time_format(movietime,\"%h:%i %p\") from timeslot where movieID = ? and moviedate = ?"
                     ,movieID,datelist.get(i));
             out.println("<div class=\"mb-3\"><p class=\"mb-2\">" + formatteddatelist.get(i) + "</p>");
             %>
          <%   while (timeslotset.next()){
                 out.println( "<a class=\" btn btn-primary btn-sm d-inline mt-3\"><span style=\"color:#ffffff\">" + timeslotset.getString(1) + "</span></a>");

             }%>
        </div>
    <%
          }
        }
             %>
        </div>
        <div>
            <h3 class="mt-3 mb-2" style="border-bottom: #b8b8b8 1px solid">SPMovy Member's Reviews</h3>
            <%
                if(moviestatus.equalsIgnoreCase("Coming soon")){
                    out.print("<h5>Sorry this movie has not been released yet.");
                }
                else{
            %>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary btn-sm float-right mb-2" data-toggle="modal" data-target="#exampleModal">
                Write a review
            </button>
            <br>

            <div>
            <%
                String reviewSentence;
                String name;
                int rating;
                String createat;
                try {
                    ResultSet getreviews = db.executeQuery("SELECT reviewSentence,name,rating, DATE_FORMAT(createdat,\"%d/%m/%Y %r\") FROM reviews WHERE movieid=?", movieID);
                    while (getreviews.next()) {
                        reviewSentence = getreviews.getString(1);
                        name = getreviews.getString(2);
                        rating = getreviews.getInt(3);
                        createat = getreviews.getString(4);

                        out.println("<div class=\"row mt-4\">");
                        out.println("<div class=\"col-sm-3\"><p class=\"text-center\"><strong>" + StringEscapeUtils.escapeHtml4(name) + "</strong></p><p class=\"text-center\">" + createat + "</p></div>");
                        out.println("<div class=\"col-md-6\"><p>" + StringEscapeUtils.escapeHtml4(reviewSentence) + "</p></div>");
                        out.println("<div class=\"col-sm\"><div class=\"stars stars-example-fontawesome-o\">" +
                                "<select class=\"example-fontawesome-o\" name=\"rating\" data-current-rating=\"" + rating + "\">" +
                                "<option value=\"1\">1</option>" +
                                "<option value=\"2\">2</option>" +
                                "<option value=\"3\">3</option>" +
                                "<option value=\"4\">4</option>" +
                                "<option value=\"5\">5</option>" +
                                "</select></div></div></div>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendRedirect("/errors/error.html");
                    return;
                }
            %>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Write a Review</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="/backend/AddReview" method="post">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
                                </div>
                                <div class="form-group">
                                    <label for="review">Review</label>
                                    <textarea name="review" id="review" rows="4" cols="48" placeholder="Enter your review" style="resize: none" required></textarea>
                                </div>
                                <div class="form-group">
                                    <div class="stars stars-example-fontawesome">
                                        <select id="example-fontawesome" name="rating" autocomplete="off">
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                        <span class="title">Rate the movie out of 5!</span>
                                    </div>
                                </div>
                                <br>
                                <br>
                                <%out.print("<input type=\"hidden\" name=\"movieid\" value=\"" + movieID + "\">");%>
                                <input type="submit" value="Submit" class="btn btn-primary">
                            </form>
                        </div>
                    </div>
                </div>
            </div>


        </div>

         <%
             }
            db.closeConnection();
     %>

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
<script src="js/jquery.barrating.js"></script>
<script src="js/examples.js"></script>
</body>
</html>
