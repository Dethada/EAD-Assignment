<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html"%>
<title>Update Movie</title>
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
                <div class="dropdown-menu active" aria-labelledby="navbarDropdown">
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
            <input class="form-control mr-sm-2" type="search" placeholder="Actors" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="#">Logout</a>
            </li>
        </ul>
    </div>
</nav>
<%@ page import="java.sql.*,org.apache.commons.lang3.StringEscapeUtils" %>
<%
    int id = 1;
    if (request.getParameter("id") == null) {
        response.sendRedirect("/admin/movies.jsp");
    } else {
        id = Integer.parseInt(request.getParameter("id"));
    }
    String title = "";
    String releasedate = "";
    String synopsis = "";
    int duration = 0;
    String imagepath = "";
    String status = "";
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    try {
        Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        PreparedStatement prepared = connection.prepareStatement("SELECT * FROM movie where ID=?");
        prepared.setInt(1, id);
        ResultSet rs = prepared.executeQuery();
        if (rs.next()) {
            out.print("<tr>");
            title = rs.getString("title");
            releasedate = String.valueOf(rs.getDate("releasedate"));
            synopsis = rs.getString("synopsis");
            duration = rs.getInt("duration");
            imagepath = rs.getString("imagepath");
            status = rs.getString("status");
        }
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<form method="post" action="/backend/updateMovie.jsp">
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Title</label>
        <div class="col-md-3">
            <input class="form-control" type="text" name="title" value="<%= StringEscapeUtils.escapeHtml4(title) %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Release Date</label>
        <div class="col-md-3">
            <input class="form-control" type="date" name="releasedate" value="<%= releasedate %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Synopsis</label>
        <div class="col-md-3">
            <textarea rows="6" class="form-control" type="text" name="synopsis" required><%= StringEscapeUtils.escapeHtml4(synopsis) %></textarea>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Duration</label>
        <div class="col-md-3">
            <input class="form-control" type="number" name="duration" value="<%= duration %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Image Path</label>
        <div class="col-md-3">
            <input class="form-control" type="text" name="imagepath" value="<%= StringEscapeUtils.escapeHtml4(imagepath) %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Status</label>
        <select name="status" class="custom-select col-md-3" required>
            <option <% if(status.equals("Coming Soon")) {out.print("selected=\"selected\"");} %> value="Coming Soon">Coming Soon</option>
            <option <% if(status.equals("Now Showing")) {out.print("selected=\"selected\"");} %> value="Now Showing">Now Showing</option>
            <option <% if(status.equals("Over")) {out.print("selected=\"selected\"");} %> value="Over">Over</option>
        </select>
    </div>
    <input type="hidden" name="id" value="<%= id %>">
    <div class="form-group row">
        <div class="col-sm-10">
            <button type="submit" class="btn btn-primary">Update Movie</button>
        </div>
    </div>
</form>
</body>
<%@ include file="footer.html"%>
