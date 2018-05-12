<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html"%>
<title>Update Genre</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/admin/adminPanel.jsp">SPMovy Admin</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Movies
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="/admin/movies.jsp">List Movies</a>
                    <a class="dropdown-item" href="/admin/addMovie.jsp">Add Movie</a>
                </div>
            </li>
            <li class="nav-item dropdown active">
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
<%@ page import="java.sql.*,org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="com.spmovy.DatabaseUtils" %>
<%
    int id = 1;
    if (request.getParameter("id") == null) {
        response.sendRedirect("/admin/genres.jsp");
    } else {
        id = Integer.parseInt(request.getParameter("id"));
    }
    String name = "";
    String description = "";
    DatabaseUtils db = new DatabaseUtils();

    try {
        ResultSet rs = db.executeQuery("SELECT * FROM Genre where ID=?", id);
        if (rs.next()) {
            out.print("<tr>");
            name = rs.getString("name");
            description = rs.getString("description");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("/error.html");
    } finally {
        db.closeConnection();
    }
%>
<form method="post" action="/backend/admin/UpdateGenre">
    <div class="form-group row">
        <label for="name" class="col-sm-2 col-form-label">Name</label>
        <div class="col-md-3">
            <input id="name" class="form-control" type="text" name="name" value="<%= StringEscapeUtils.escapeHtml4(name) %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label for="description" class="col-sm-2 col-form-label">Description</label>
        <div class="col-md-3">
            <textarea id="description" rows="6" class="form-control" type="text" name="description" required><%= StringEscapeUtils.escapeHtml4(description) %></textarea>
        </div>
    </div>
    <input type="hidden" name="id" value="<%= id %>">
    <div class="form-group row">
        <div class="col-sm-10">
            <button type="submit" class="btn btn-primary">Update Genre</button>
        </div>
    </div>
</form>
</body>
<%@ include file="footer.html"%>
