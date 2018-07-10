<%@page contentType="text/html; charset=utf-8" errorPage="DBError.jsp" %>
<%@page import="java.sql.*"%>

<%
    String token = (String)session.getAttribute("token");
    if (token == null){
        response.sendRedirect("login.html");
    }
    int userid = (Integer)session.getAttribute("userid");
    Class.forName("com.mysql.jdbc.Driver");
    Class.forName("org.apache.commons.dbcp.PoolingDriver");
    Connection conn = DriverManager.getConnection("jdbc:apache:commons:dbcp:/dbauto_pool");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <title>OnNote <%=userid%></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.42/css/uikit.min.css" />
    <script src="https://rawgit.com/showdownjs/showdown/develop/dist/showdown.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.42/js/uikit.min.js" integrity="sha256-yl7w0KuhRsVzOpDk7EoWE2EVwwOFXPlfQDQDtwsg5ds="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-beta.42/js/uikit-icons.min.js" integrity="sha256-pelC1MOe8KcWCQWSbkMF83x3Hb+K3xn3Fua5IUMexkU="
        crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.13.1/min/vs/loader.js"></script>
    <script type="text/javascript" src="mainjs.js"></script>
    <script src="monaco.js"></script>
    <style>
    
        * {
            text-transform:none !important;
        }
        .main-box {
            width: 100%;
            height: 800px;
            overflow:hidden;
        }

        .main-box>* {
            float: left;
            display: block;
        }

        .side-bar {
            width: 10%;
            height: 100%;
        }

        #editor {
            width: 40%;
            height: 600px;
        }

        #preview-frame {
            width:44.85%;
            height: 600px;
            border:1px solid black;
        }

    </style>
</head>

<body>

    <nav class="uk-navbar-container uk-margin" uk-navbar>
        <div class="uk-navbar-left">

            <a class="uk-navbar-item uk-logo" href="#">
                <span class="uk-margin-small-right" uk-icon="icon: code; ratio: 2"></span>
                OnNote</a>

            <ul class="uk-navbar-nav">
                <li>
                    <a href="#">
                        <span class="uk-icon uk-margin-small-right" uk-icon="icon: star"></span>
                        Features
                    </a>
                </li>
            </ul>

            <div class="uk-navbar-item">
                <a class="uk-link-text" href="#">설명서</a>
            </div>
        </div>

        <div class="uk-navbar-item">
            <form action="javascript:void(0)">
                <input class="uk-input uk-form-width-small" type="text" placeholder="Input">
                <button class="uk-button uk-button-default">Button</button>
            </form>
        </div>

        </div>
        <div class="uk-navbar-right">
            <a href="/sanghie/logout.jsp" class="uk-navbar-item uk-link-text">
                <span class="uk-text-large uk-margin-small-right">Logout</span>
                <span uk-icon="icon: sign-out; ratio: 1.5"></span>

            </a>
        </div>
    </nav>
    <div class="main-box">
        <div class="side-bar">
            <ul class="uk-tab-left" uk-tab>
                <li class="uk-active">
                    <a href="#">Welcome</a>
                </li>
                <%
                    String query = "select memoid, title, content from project_memo where uid = ?";
                    PreparedStatement pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, userid);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        out.println("<li id=memo"+rs.getInt(1)+" onclick=\"editor.setValue(`"+ rs.getString(3) +"`);\"><a>"+rs.getString(2)+"<span class=\"uk-float-right\" uk-icon=\"icon: minus\" onclick=\"removeMemo(this, "+ rs.getString(1)+");\"></span></a></li>");
                        
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                %>
            </ul>
        </div>

        <div id="editor"></div>
        <iframe id="preview-frame" src="" frameborder="0"></iframe>
    </div>

</body>

</html>