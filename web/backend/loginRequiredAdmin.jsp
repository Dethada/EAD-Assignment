<%@ page import="java.util.Objects" %><%
    if (session.getAttribute("userid") == null && !Objects.equals(session.getAttribute("role"), "admin")) {
        response.sendRedirect("/admin/admin.jsp?login=Not");
    }
%>
