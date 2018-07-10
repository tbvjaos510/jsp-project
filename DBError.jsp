<%@page contentType="text/html; charset=utf-8" isErrorPage="true" %>
<% response.setStatus(200); %>
<html><head><title>에러</title></head>
    <body><h3>에러</h3>
    에러 메시지 : <%=exception.getMessage()%> <br>
    에러 위치 : <%=exception.getStackTrace()[0]%>
    </body>
</html>
