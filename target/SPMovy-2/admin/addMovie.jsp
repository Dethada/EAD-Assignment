<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/admin/header.html" %>
<title>Add Movie</title>
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
        <form class="form-inline my-2 my-lg-0" action="movies.jsp">
            <input class="form-control mr-sm-2" type="search" name="moviename" placeholder="Movie Title"
                   aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="/backend/Logout">Logout</a>
            </li>
        </ul>
    </div>
</nav>
<h1>Movie</h1>
<form method="post" action="/backend/admin/AddMovie">
    <div class="form-group row">
        <label for="title" class="col-sm-2 col-form-label">Title</label>
        <div class="col-md-3">
            <input id="title" class="form-control" type="text" name="title" placeholder="Title" required>
        </div>
    </div>
    <div class="form-group row">
        <label for="releasedate" class="col-sm-2 col-form-label">Release Date</label>
        <div class="col-md-3">
            <input type="date" name="releasedate" class="form-control" id="releasedate" required>
        </div>
    </div>
    <div class="form-group row">
        <label for="synopsis" class="col-sm-2 col-form-label">Synopsis</label>
        <div class="col-md-3">
            <textarea id="synopsis" rows="6" class="form-control" type="text" name="synopsis" placeholder="Synopsis"
                      required></textarea>
        </div>
    </div>
    <div class="form-group row">
        <label for="duration" class="col-sm-2 col-form-label">Duration (mins)</label>
        <div class="col-md-3">
            <input type="number" class="form-control" name="duration" id="duration" required>
        </div>
    </div>
    <div class="form-group row">
        <input type="hidden" id="next" value="1"/>
        <label for="genres" class="col-sm-2 col-form-label">Genres</label>
        <div class="col-md-3" id="genres">
            <input class="form-control" id="field1" name="genre" type="text" placeholder="Genre" required>
            <button id="b1" class="btn add-more" type="button">+</button>
        </div>
    </div>
    <div class="form-group row">
        <input type="hidden" id="next2" value="1"/>
        <label for="actors" class="col-sm-2 col-form-label">Actors</label>
        <div class="col-md-3" id="actors">
            <input class="form-control" id="fieldz1" name="actor" type="text" placeholder="Actor" required>
            <button id="bt1" class="btn add-more2" type="button">+</button>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label">Status</label>
        <select name="status" class="custom-select col-md-3 form-control" required>
            <option value="Coming Soon">Coming Soon</option>
            <option value="Now Showing">Now Showing</option>
            <option value="Over">Over</option>
        </select>
    </div>
    <div class="form-group row">
        <label for="customFile" class="col-sm-2 col-form-label">Movie Poster</label>
        <div class="col-md-3 custom-file">
            <input type="file" class="custom-file-input" id="customFile" name="myImage">
            <label class="custom-file-label" for="customFile">Choose image file...</label>
        </div>
    </div>
    <input type="hidden" name="imagepath" value="image/default.svg">
    <div class="form-group row">
        <div class="col-sm-10">
            <button type="submit" class="btn btn-primary">Add Movie</button>
        </div>
    </div>
</form>
</body>
<script src="/js/dynamicfields.js" defer></script>
<%@ include file="/admin/footer.html" %>
