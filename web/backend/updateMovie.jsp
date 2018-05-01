<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String releasedate = request.getParameter("releasedate");
    String synopsis = request.getParameter("synopsis");
    int duration = Integer.parseInt(request.getParameter("duration"));
    String imagepath = request.getParameter("imagepath");
    String status = request.getParameter("status");
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    try {
        Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        PreparedStatement prepared = connection.prepareStatement("UPDATE movie SET title=?, releasedate=?, synopsis=?, duration=?, imagepath=?, status=? WHERE ID=?");
        prepared.setString(1, title);
        prepared.setDate(2, Date.valueOf(releasedate));
        prepared.setString(3, synopsis);
        prepared.setInt(4, duration);
        prepared.setString(5, imagepath);
        prepared.setString(6, status);
        prepared.setInt(7, id);
        prepared.executeUpdate();
        connection.close();
        response.sendRedirect("/admin/movies.jsp");
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
