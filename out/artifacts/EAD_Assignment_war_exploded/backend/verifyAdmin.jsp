<%--
  Created by IntelliJ IDEA.
  User: david
  Date: 27/4/18
  Time: 9:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Login</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%  String username = request.getParameter("username");
    String password = request.getParameter("password");
    String driverName = "com.mysql.jdbc.Driver";
    Class.forName(driverName);
    String url = "jdbc:mysql://52.74.214.114/spmovy?autoReconnect=true&verifyServerCertificate=false&useSSL=true";

    try {
        Connection connection = DriverManager.getConnection(url, "spmovy", "15Pb6pc%$8!@P^NR$h@5rLM84gJvR2u1p72F^3");
        PreparedStatement prepared = connection.prepareStatement("SELECT * FROM users where username=? and password=?");
        prepared.setString(1, username);
        prepared.setString(2, password);
        ResultSet rs = prepared.executeQuery();
        if (rs.next()) {
            // login sucessful
            session.setAttribute("userid", rs.getInt("ID"));
            session.setAttribute("role", rs.getString("role"));
            prepared = connection.prepareStatement("UPDATE users SET lastloginip=?, lastlogintime=? WHERE username=?");
            prepared.setString(1, request.getRemoteAddr());
            prepared.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            prepared.setString(3, username);
            prepared.executeUpdate();
            response.sendRedirect("/admin/adminPanel.jsp");
        } else {
            // login failed
            response.sendRedirect("/admin/admin.jsp?login=Failed");
        }
        connection.close();
    } catch (Exception e) {
        // log the error here and maybe notify admin somehow
    }
%>
</body>
</html>
