<%@page contentType="text/html; charset=utf-8" errorPage="DBError.jsp" %>
<%@page import="java.sql.*"%>
<html>
<head>
    <title>데이터베이스 커넥션 풀 테스트</title>
    <script src="js/uikit.min.js"></script>
    <script src="js/uikit-icons.min.js"></script>
    <link rel="stylesheet" href="css/uikit.min.css">
</head>
    <body>
        <h3 class="uk-h3">데이터베이스 커넥션 풀 테스트</h3>
        <%
        Class.forName("com.mysql.jdbc.Driver");
        Class.forName("org.apache.commons.dbcp.PoolingDriver");
        Connection conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/dbauto_pool");
        String id = request.getParameter("id");
        String pw = request.getParameter("password");
        
        if (id == null || pw == null)
        {
            out.println("인자값이 없어요.");
        }
        if (conn != null){
            out.println("연결 취득 완료<br>");
            conn.close();
            out.println("연결 반환 완료<br>");
        } else {
            out.println("연결 취득 실패<br>");
        }
        %>
        
    </body>
</html>