<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>
<title>Reviews</title>
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
            <li class="nav-item dropdown active">
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
<%@ page import="java.sql.*,org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="com.spmovy.DatabaseUtils" %>
<%@ page import="com.spmovy.Utils" %>
<%
    int movieid = Integer.parseInt(request.getParameter("id"));
    DatabaseUtils db = Utils.getDatabaseUtils(response);
    if (db == null) return;
    ResultSet rs = db.executeQuery("SELECT title FROM movie WHERE ID=?", movieid);
    String title = "";
    try {
        if (rs.next()) {
            title = rs.getString("title");
        } else {
            response.sendRedirect("/admin/movies.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("/error.html");
    }
%>
<h2><%= title %>
</h2>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Rating</th>
        <th scope="col">Comment</th>
        <th scope="col">Created At</th>
        <th scope="col">IP</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        try {
            rs = db.executeQuery("SELECT * FROM reviews where movieID=?", movieid);
            while (rs.next()) {
                out.print("<td>" + StringEscapeUtils.escapeHtml4(rs.getString("name")) + "</td><td>" +
                        rs.getInt("rating") + "</td><td>" + StringEscapeUtils.escapeHtml4(rs.getString("reviewSentence")) +
                        "</td><td>" + rs.getTimestamp("createdat") + "</td><td>" + StringEscapeUtils.escapeHtml4(rs.getString("ip")) + "</td>");
                out.print("<td><form method=\"post\" action=\"/backend/admin/DeleteReview\">" +
                        "<input type=\"hidden\" name=\"table\" value=\"reviews\">" +
                        "<input type=\"hidden\" name=\"movieid\" value=\"" + movieid + "\">" +
                        "<input type=\"hidden\" name=\"reviewid\" value=\"" + rs.getInt("reviewID") + "\">" +
                        "<input class=\"btn btn-danger\" type=\"submit\" value=\"Delete\"></form></td>");
                out.print("</tr>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/error.html");
        } finally {
            db.closeConnection();
        }
    %>
    </tbody>
</table>
</body>
<%@ include file="footer.html" %>
