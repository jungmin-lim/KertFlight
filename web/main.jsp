<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.TimeZone" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Welcome to KertFlight</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css">
</head>
<body>
    <div class="main">
        <div class="navbar">
            <div class="icon">
                <h2 class="logo">KertFlight</h2>
            </div>
            <div class="menu">
                <ul>
                    <li><a href="#">BOOK</a></li>
                    <li><a href="#">AIRPORT</a></li>
                    <li><a href="#">IN-FLIGHT</a></li>
                </ul>
            </div>
        </div>
    <%
        // Database connection
        String serverIP = "155.230.52.58";
        String strSID = "xe";
        String portNum = "16190";
        String user = "kertflight";
        String pass = "kertorkr";
        String url = "jdbc:oracle:thin:@"+serverIP + ":" + portNum + ":" + strSID;

        try{
            TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
            TimeZone.setDefault(timeZone);

            Connection conn = null;
            PreparedStatement pstmt;
            ResultSet rs;
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
            out.println("alert(\"Oracle Driver Class not found\")");
        } catch(SQLException e) {
            e.printStackTrace();
            out.println("alert(\"DBMS Connection Error\")");
        }
    %>

    </div>
</body>
</html>