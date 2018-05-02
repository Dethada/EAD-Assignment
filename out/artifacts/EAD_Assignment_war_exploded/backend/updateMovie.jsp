<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.util.Map,java.util.ArrayList" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String releasedate = request.getParameter("releasedate");
    String synopsis = request.getParameter("synopsis");
    int duration = Integer.parseInt(request.getParameter("duration"));
    String imagepath = request.getParameter("imagepath");
    String status = request.getParameter("status");
    ArrayList<String> genres = new ArrayList();
    ArrayList<String> actors = new ArrayList();
    Map<String, String[]> parameters = request.getParameterMap();
    // put genre and actor into respective array lists
    if (parameters.size() == 0) {
        response.sendRedirect("/admin/movies.jsp");
    } else {
        for (String parameter : parameters.keySet()) {
            if (parameter.contains("genre")) {
                genres.add(request.getParameter(parameter));
            } else if (parameter.contains("actor")) {
                actors.add(request.getParameter(parameter));
            }
        }
    }
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    Connection connection = null;
    try {
        connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
    } catch (Exception e) {
        e.printStackTrace();
    }
    PreparedStatement prepared = connection.prepareStatement("UPDATE movie SET title=?, releasedate=?, synopsis=?, duration=?, imagepath=?, status=? WHERE ID=?");
    prepared.setString(1, title);
    prepared.setDate(2, Date.valueOf(releasedate));
    prepared.setString(3, synopsis);
    prepared.setInt(4, duration);
    prepared.setString(5, imagepath);
    prepared.setString(6, status);
    prepared.setInt(7, id);
    prepared.executeUpdate();
    PreparedStatement getGenreID = connection.prepareStatement("SELECT * FROM Genre WHERE name=?");
    PreparedStatement getActorID = connection.prepareStatement("SELECT * FROM actor WHERE name=?");
    // get movie id
    PreparedStatement getMovieID = connection.prepareStatement("SELECT * FROM movie WHERE title=? and releasedate=?");
    getMovieID.setString(1, title);
    getMovieID.setDate(2, java.sql.Date.valueOf(releasedate));
    ResultSet movieIDResult = getMovieID.executeQuery();
    movieIDResult.next();
    int movieid = movieIDResult.getInt("ID");
    // get list of current genres
    ArrayList<Integer> currentGenres = new ArrayList();
    PreparedStatement getCurrentGenres = connection.prepareStatement("SELECT * FROM MovieGenre WHERE movieID=?");
    getCurrentGenres.setInt(1, movieid);
    ResultSet currentGenresrs = getCurrentGenres.executeQuery();
    while (currentGenresrs.next()) {
        currentGenres.add(currentGenresrs.getInt("genreID"));
    }
    // get list of current actors
    ArrayList<Integer> currentActors = new ArrayList();
    PreparedStatement getCurrentActors = connection.prepareStatement("SELECT * FROM MovieActor WHERE movieID=?");
    getCurrentActors.setInt(1, movieid);
    ResultSet currentActorsrs = getCurrentActors.executeQuery();
    while (currentActorsrs.next()) {
        currentActors.add(currentActorsrs.getInt("actorID"));
    }
    // prepare insert statements
    PreparedStatement insertGenre = connection.prepareStatement("insert into MovieGenre values (?, ?)");
    PreparedStatement insertActor = connection.prepareStatement("insert into MovieActor values (?, ?)");
    insertGenre.setInt(1, movieid);
    insertActor.setInt(1, movieid);
    // add genres for movie
    for(String genre : genres) {
        getGenreID.setString(1, genre);
        ResultSet rs = getGenreID.executeQuery();
        if (rs.next()) {
            int tmpID = rs.getInt("ID");
            if (currentGenres.contains(tmpID)) {
                currentGenres.remove(Integer.valueOf(tmpID));
            } else {
                insertGenre.setInt(2, tmpID);
                try {
                    insertGenre.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    // delete genres
    PreparedStatement deleteGenre = connection.prepareStatement("DELETE FROM MovieGenre WHERE movieID=? AND genreID=?");
    deleteGenre.setInt(1, movieid);
    for(int deleteid : currentGenres) {
        deleteGenre.setInt(2, deleteid);
        deleteGenre.executeUpdate();
    }

    // add actors for movie
    for(String actor : actors) {
        getActorID.setString(1, actor);
        ResultSet rs = getActorID.executeQuery();
        if (rs.next()) {
            int tmpID = rs.getInt("ID");
            if (currentActors.contains(tmpID)) {
                currentActors.remove(Integer.valueOf(tmpID));
            } else {
                insertActor.setInt(2, tmpID);
                try {
                    insertActor.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    // delete actors
    PreparedStatement deleteActor = connection.prepareStatement("DELETE FROM MovieActor WHERE movieID=? AND actorID=?");
    deleteActor.setInt(1, movieid);
    for(int deleteid : currentActors) {
        deleteActor.setInt(2, deleteid);
        deleteActor.executeUpdate();
    }

    connection.close();
    response.sendRedirect("/admin/movies.jsp");
%>
