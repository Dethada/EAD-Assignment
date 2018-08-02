<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>
<title>Time Slot</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/admin/adminPanel">SPMovy Admin</a>
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
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">
                    Users
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/Users">List Users</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true"
                   aria-expanded="false">
                    Account
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/changePassword.jsp">Change Password</a>
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
<%@ page import="com.spmovy.Utils" %>
<%
    DatabaseUtils db = Utils.getDatabaseUtils(response);
    if (db == null) return;
    int id = Integer.parseInt(request.getParameter("id"));
    ResultSet rs = db.executeQuery("SELECT title FROM movie WHERE ID=?", id);
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
<h2 class="ml-2 pl-2 mt-2"><%=title%></h2>
<form class="form-inline px-0 mx-0 mb-2" method="post" action="/backend/admin/AddTimeslot">
    <div class="form-group mx-sm-3 mb-2">
        <label class="col-form-label mr-1">Date</label>
        <input type="date" name="date" class="form-control">
    </div>
    <div class="form-group mx-sm-3 mb-2">
        <label class="col-form-label mr-1" 2>Time</label>
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
        try {
            rs = db.executeQuery("SELECT * FROM timeslot where movieID=?", id);
            while (rs.next()) {
                out.print("<td>" + rs.getString("moviedate") + "</td><td>" + rs.getString("movietime") + "</td>");
                out.print("<td><form style=\"padding: 0;\" method=\"post\" action=\"/backend/admin/DeleteTimeslot\">" +
                        "<input type=\"hidden\" name=\"movietime\" value=\"" + rs.getString("movietime") + "\">" +
                        "<input type=\"hidden\" name=\"moviedate\" value=\"" + rs.getString("moviedate") + "\">" +
                        "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
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
