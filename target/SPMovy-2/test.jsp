<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 04-Aug-18
  Time: 12:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String seatarr = (String)request.getAttribute("seatarr");
    out.print(seatarr);
%>
</body>
</html>
