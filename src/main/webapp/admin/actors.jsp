<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>
<title>Actors</title>
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
            <li class="nav-item dropdown active">
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
        <div class="w-50">
            <form class="form-inline mt-2 mb-2 float-right" action="actors.jsp">
                <input class="form-control mr-sm-2" name="actorname" type="search" placeholder="Actors" aria-label="Search">
                <button class="btn btn-outline-dark my-2 my-sm-0 mr-1" type="submit">Search</button>
                <a class="btn btn-outline-danger" href="/backend/Logout">Logout</a>
            </form>
        </div>
    </div>
</nav>
<%@ page import="java.sql.ResultSet,com.spmovy.DatabaseUtils,org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.spmovy.Utils" %>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Description</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        DatabaseUtils db = Utils.getDatabaseUtils(response);
        if (db == null) return;
        ResultSet rs;
        if (request.getParameter("actorname") == null) {
            rs = db.executeFixedQuery("SELECT * FROM actor");
        } else {
            rs = db.executeQuery("SELECT * FROM actor WHERE Name LIKE ?", "%" + request.getParameter("actorname") + "%");
        }
        try {
            while (rs.next()) {
                out.print("<tr>");
                int id = rs.getInt("ID");
                String name = rs.getString("name");
                String description = rs.getString("description");
                out.print("<td>" + StringEscapeUtils.escapeHtml4(name) + "</td><td>" + StringEscapeUtils.escapeHtml4(description) + "</td>");
                out.print("<td><form method=\"post\" action=\"/admin/updateActor.jsp\">" +
                        "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                        "<input class=\"btn btn-secondary\" type=\"submit\" value=\"Edit\"></form>" +
                        "<form method=\"post\" action=\"/backend/admin/Delete\">" +
                        "<input type=\"hidden\" name=\"table\" value=\"actor\">" +
                        "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                        "<input class=\"btn btn-danger\" type=\"submit\" value=\"Delete\"></form></td>");
                out.print("</tr>");
            }
        } catch (SQLException e) {
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
