<%@page contentType="text/html; charset=utf-8" errorPage="DBError.jsp" %>

<%
    session.invalidate();
    response.sendRedirect("/sanghie/main.jsp");
%>