<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.TimeZone" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Welcome to KertFlight</title>
</head>
<body>
    <h2>KertFlight</h2>
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
            out.println("Class not found");
        } catch(SQLException e) {
            e.printStackTrace();
            out.println("SQL Error");
        } finally {
            out.println("connected!");
        }
    %>
</body>
</html>