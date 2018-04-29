<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.html"%>
<title>Update Genre</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <a class="navbar-brand" href="/admin/adminPanel.jsp">SPMovy Admin</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
            <a class="nav-item nav-link" href="/admin/movies.jsp">Movies</a>
            <a class="nav-item nav-link active" href="/admin/genres.jsp">Genres</a>
            <a class="nav-item nav-link" href="/admin/actors.jsp">Actors</a>
            <a class="nav-item nav-link" href="/admin/addMovie.jsp">Add Movie</a>
        </div>
    </div>
</nav>
<%@ page import="java.sql.*" %>
<%
    int id = 1;
    if (request.getParameter("id") == null) {
        response.sendRedirect("/admin/genres.jsp");
    } else {
        id = Integer.parseInt(request.getParameter("id"));
    }
    String name = "";
    String description = "";
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    try {
        Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        PreparedStatement prepared = connection.prepareStatement("SELECT * FROM Genre where ID=?");
        prepared.setInt(1, id);
        ResultSet rs = prepared.executeQuery();
        if (rs.next()) {
            out.print("<tr>");
            name = rs.getString("name");
            description = rs.getString("description");
        }
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<form method="post" action="/backend/processUpdateGenre.jsp">
    <div class="form-group row">
        <label for="name" class="col-sm-2 col-form-label">Name</label>
        <div class="col-md-3">
            <input id="name" class="form-control" type="text" name="name" value="<%= name %>" required>
        </div>
    </div>
    <div class="form-group row">
        <label for="description" class="col-sm-2 col-form-label">Description</label>
        <div class="col-md-3">
            <textarea id="description" rows="6" class="form-control" type="text" name="description" required><%= description %></textarea>
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
