<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 29/4/2018
  Time: 3:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.sql.*" import="java.util.*" %>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String movieID = request.getParameter("movieid");
    Connection conn = DriverManager.getConnection("jdbc:mysql://52.74.214.114:3306/spmovy","spmovy","15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");

    // get actors
    PreparedStatement showactors = conn.prepareStatement("SELECT movie.title, actor.name from MovieActor inner join movie on MovieActor.movieID = movie.ID inner join actor on MovieActor.actorID = actor.ID where movie.id = ?");
    showactors.setObject(1, movieID);
    ArrayList<String> actorlist = new ArrayList<>();
    ResultSet rs2 = showactors.executeQuery();
    while(rs2.next()){
        actorlist.add(rs2.getString(2));
    }
    String actor = actorlist.toString();
    actor = actor.replaceAll("[\\[\\]]", "");

    // get genres
    PreparedStatement showgenre = conn.prepareStatement("select Genre.name from MovieGenre inner join movie on MovieGenre.movieID = movie.ID inner join Genre on MovieGenre.genreID = Genre.ID where movie.id=?");
    showgenre.setObject(1,movieID);
    ArrayList<String> genrelist = new ArrayList<>();
    ResultSet rs3 = showgenre.executeQuery();
    while(rs3.next()){
        genrelist.add(rs3.getString(1));
    }
    String genre = genrelist.toString();
    genre = genre.replaceAll("[\\[\\]]", "");

%>

