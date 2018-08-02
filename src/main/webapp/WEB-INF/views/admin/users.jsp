<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/admin/header.html" %>
<%@ page import="com.spmovy.beans.UserJB" %>
<%@ page import="java.util.ArrayList" %>
<title>Users</title>
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
            <li class="nav-item dropdown active">
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
            <form class="form-inline my-2 my-lg-0" action="/admin/Users">
                <input class="form-control mr-sm-2" name="username" type="search" placeholder="Users" aria-label="Search">
                <button class="btn btn-outline-dark my-2 my-sm-0 mr-2" type="submit">Search</button>
                <a class="btn btn-outline-danger" href="/backend/Logout">Logout</a>
            </form>
        </div>
    </div>
</nav>
<table class="table">
    <thead class="thead-dark">
    <tr>
        <th scope="col">Username</th>
        <th scope="col">Email</th>
        <th scope="col">Contact</th>
        <th scope="col">View Details</th>
        <th scope="col">Delete</th>
    </tr>
    </thead>
    <tbody>
    <% ArrayList<UserJB> userlist = (ArrayList<UserJB>)request.getAttribute("userlist"); 
    for (UserJB user: userlist) { %>
        <tr>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getContact() %></td>
        <td><a class="btn btn-info" href="/admin/userdetail?id=<%= user.getID() %>">View</a></td>
        <td>
        <form style="padding: 0;" method="post" action="/backend/admin/Delete">
            <input type="hidden" name="table" value="users">
            <input type="hidden" name="id" value="<%= user.getID() %>">
            <input class="btn btn-danger" type="submit" value="Delete"></form>
        </td>
        </tr>
    <% } %>
    </tbody>
</table>
</body>
<%@ include file="/admin/footer.html" %>
