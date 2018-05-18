<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html" %>
<title>Genres</title>
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
            <li class="nav-item dropdown active">
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
        <form class="form-inline my-2 my-lg-0" action="genres.jsp">
            <input class="form-control mr-sm-2" name="genrename" type="search" placeholder="Genres" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/backend/Logout">Logout</a>
            </li>
        </ul>
    </div>
</nav>
<%@ page
        import="java.sql.ResultSet,com.spmovy.DatabaseUtils,java.sql.SQLException,org.apache.commons.lang3.StringEscapeUtils" %>
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
        if (request.getParameter("genrename") == null) {
            rs = db.executeFixedQuery("SELECT * FROM Genre");
        } else {
            rs = db.executeQuery("SELECT * FROM Genre WHERE name LIKE ?", "%" + request.getParameter("genrename") + "%");
        }
        try {
            while (rs.next()) {
                out.print("<tr>");
                int id = rs.getInt("ID");
                String name = rs.getString("name");
                String description = rs.getString("description");
                out.print("<td>" + StringEscapeUtils.escapeHtml4(name) + "</td><td>" + StringEscapeUtils.escapeHtml4(description) + "</td>");
                out.print("<td><form action=\"/admin/updateGenre.jsp\">" +
                        "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                        "<input class=\"btn btn-secondary\" type=\"submit\" value=\"Edit\"></form>" +
                        "<form method=\"post\" action=\"/backend/admin/Delete\">" +
                        "<input type=\"hidden\" name=\"table\" value=\"Genre\">" +
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
