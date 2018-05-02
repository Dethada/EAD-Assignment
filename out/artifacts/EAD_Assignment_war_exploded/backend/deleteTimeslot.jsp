<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String date = request.getParameter("moviedate");
    String time = request.getParameter("movietime");
    System.out.println(time);
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    Connection connection = null;
    try {
        connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
    } catch (Exception e) {
        e.printStackTrace();
    }
    PreparedStatement deleteTimeslot = connection.prepareStatement("delete from timeslot where movietime=? and moviedate=? and movieID=?");
    try {
        deleteTimeslot.setTime(1, Time.valueOf(time));
        deleteTimeslot.setDate(2, Date.valueOf(date));
        deleteTimeslot.setInt(3, id);
        deleteTimeslot.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    connection.close();
    response.sendRedirect(String.valueOf(session.getAttribute("prevpage")));
%>
