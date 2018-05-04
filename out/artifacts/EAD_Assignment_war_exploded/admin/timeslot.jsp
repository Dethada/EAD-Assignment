<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html"%>
    <title>Time Slot</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/admin/adminPanel.jsp">SPMovy Admin</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown active">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Movies
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/movies.jsp">List Movies</a>
                    <a class="dropdown-item" href="/admin/addMovie.jsp">Add Movie</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Genres
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/genres.jsp">List Genres</a>
                    <a class="dropdown-item" href="/admin/addGenre.jsp">Add Genre</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Actors
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/actors.jsp">List Actors</a>
                    <a class="dropdown-item" href="/admin/addActor.jsp">Add Actor</a>
                </div>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Movie Title" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/backend/Logout">Logout</a>
            </li>
        </ul>
    </div>
</nav>
<%@ page import="java.sql.*,java.net.URLDecoder" %>
<%@ page import="com.spmovy.DatabaseUtils" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = URLDecoder.decode(request.getParameter("title"), "UTF-8");
    session.setAttribute("prevpage", "/admin/timeslot.jsp?id=" + id + "&title=" + request.getParameter("title"));
%>
<h2><%= title %></h2>
<form class="form-inline" method="post" action="/backend/admin/AddTimeslot">
    <div class="form-group mx-sm-3 mb-2">
        <label class="col-form-label">Date</label>
        <input type="date" name="date" class="form-control">
    </div>
    <div class="form-group mx-sm-3 mb-2">
        <label class="col-form-label"2>Time</label>
        <input type="time" name="time" class="form-control">
    </div>
    <input type="hidden" name="id" value="<%= id %>">
    <button type="submit" class="btn btn-primary mb-2">Add Timeslot</button>
</form>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Date</th>
        <th scope="col">Time</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>
    <tbody>
<%
    DatabaseUtils db = new DatabaseUtils();

    try {
        ResultSet rs = db.executeQuery("SELECT * FROM timeslot where movieID=?", id);
        while (rs.next()) {
            out.print("<td>" + rs.getString("moviedate") + "</td><td>" + rs.getString("movietime") + "</td>");
            out.print("<td><form method=\"post\" action=\"/admin/updateTimeslot.jsp\">" +
                    "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                    "<input class=\"btn btn-secondary\" type=\"submit\" value=\"Edit\"></form>" +
                    "<form method=\"post\" action=\"/backend/admin/DeleteTimeslot\">" +
                    "<input type=\"hidden\" name=\"movietime\" value=\"" + rs.getString("movietime") + "\">" +
                    "<input type=\"hidden\" name=\"moviedate\" value=\"" + rs.getString("moviedate") + "\">" +
                    "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                    "<input class=\"btn btn-danger\" type=\"submit\" value=\"Delete\"></form></td>");
            out.print("</tr>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        db.closeConnection();
    }
%>
    </tbody>
</table>
</body>
<%@ include file="footer.html"%>
