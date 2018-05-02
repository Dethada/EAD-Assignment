<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String date = request.getParameter("date");
    String time = request.getParameter("time")+":00";
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    Connection connection = null;
    try {
        connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
    } catch (Exception e) {
        e.printStackTrace();
    }
    PreparedStatement insertTimeslot = connection.prepareStatement("insert into timeslot values (?, ?, ?)");
    try {
        insertTimeslot.setTime(1, Time.valueOf(time));
        insertTimeslot.setDate(2, Date.valueOf(date));
        insertTimeslot.setInt(3, id);
        insertTimeslot.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    connection.close();
    response.sendRedirect(String.valueOf(session.getAttribute("prevpage")));
%>
