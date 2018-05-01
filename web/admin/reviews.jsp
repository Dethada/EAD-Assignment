<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html"%>
<title>Reviews</title>
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
                <a class="nav-link" href="#">Logout</a>
            </li>
        </ul>
    </div>
</nav>
<%@ page import="java.sql.*,java.net.URLDecoder" %>
<h2><%= URLDecoder.decode(request.getParameter("title"), "UTF-8") %></h2>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Rating</th>
        <th scope="col">Comment</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        String driverName = "com.mysql.jdbc.Driver";
        Class.forName(driverName);
        String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

        try {
            Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
            PreparedStatement prepared = connection.prepareStatement("SELECT * FROM reviews where movieID=?");
            prepared.setInt(1, id);
            ResultSet rs = prepared.executeQuery();
            while (rs.next()) {
                out.print("<td>" + rs.getString("name")+ "</td><td>" + rs.getInt("rating") + "</td><td>" + rs.getString("reviewSentence") + "</td>");
                out.print("<td><form method=\"post\" action=\"/backend/processDelete.jsp\">" +
                        "<input type=\"hidden\" name=\"from\" value=\"/admin/reviews.jsp?id=" + id + "\"&title=\"" + request.getParameter("title") + "\">" +
                        "<input type=\"hidden\" name=\"table\" value=\"timeslot\">" +
                        "<input type=\"hidden\" name=\"id\" value=\"" + id + "\">" +
                        "<input type=\"submit\" value=\"Delete\"></form></td>");
                out.print("</tr>");
            }
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    </tbody>
</table>
</body>
<%@ include file="footer.html"%>
