<%--
  Created by IntelliJ IDEA.
  User: Javiery
  Date: 31-Jul-18
  Time: 8:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    out.print(request.getParameter("movieid"));
    out.print(request.getParameter("moviedate"));
    out.print(request.getParameter("movietime"));
%>
</body>
</html>
