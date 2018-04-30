<%--
  Created by IntelliJ IDEA.
  User: david
  Date: 29/4/18
  Time: 1:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String table = request.getParameter("table");
    int id = Integer.parseInt(request.getParameter("id"));
    String from = request.getParameter("from");
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    try {
        Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        String query = "{CALL deleteProcedure(?, ?)}";
        CallableStatement stmt = connection.prepareCall(query);
        stmt.setString(1, table);
        stmt.setInt(2, id);
        stmt.execute();
        connection.close();
        response.sendRedirect(from);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
