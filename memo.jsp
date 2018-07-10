<%@page contentType="text/html; charset=utf-8"%>
<%@page import="java.sql.*"%>
<%
    String userid = "" + (Integer)session.getAttribute("userid");
    if (userid == null){         
        out.println("needs login");
        return;
    }
    Class.forName("com.mysql.jdbc.Driver");
    Class.forName("org.apache.commons.dbcp.PoolingDriver");
    Connection conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/dbauto_pool");

    String mode = request.getParameter("mode");
    if (mode == null){
        out.println("needs mode (" + mode + ")");
        return;
    }
    if (mode.equals("update")){
        String Content = request.getParameter("content");
        String memoid = request.getParameter("memoid");
        if (Content == null)
        {
            out.println("needs memoid");
            return;
        }
        if (memoid == null)
        {
            out.println("needs content");
            return;
        }
        String query = "update project_memo set content = ? where memoid = ? and uid = ?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, Content);
        pstmt.setString(2, memoid);
        pstmt.setString(3, userid);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("success");
        } else {
            out.println("failed. code " + result);
        }
        pstmt.close();
    } else if (mode.equals("remove")) {
        String memoid = request.getParameter("memoid");
        if (memoid == null)
        {
            out.println("needs memoid");
            return;
        }
        String query = "delete from project_memo where memoid=? and uid=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, memoid);
        pstmt.setString(2, userid);
        int result = pstmt.executeUpdate();
        if (result > 0){
            out.println("success");
        } else {
            out.println("failed");
        }
    } else if (mode.equals("create")) {

    } else {
        out.println("needs mode (" + mode + ")");
    }
    
    conn.close();
%>