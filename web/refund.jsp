<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.util.TimeZone, java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>COMP322: Databases</title>
</head>
<body>
<%
    String serverIP = "155.230.52.58";
    String strSID = "xe";
    String portNum = "16190";
    String user = "kertflight";
    String pass = "kertorkr";
    String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs=null;
    try {
        TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
        TimeZone.setDefault(timeZone);
        Class.forName("oracle.jdbc.driver.OracleDriver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    try {
        conn = DriverManager.getConnection(url,user,pass);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    String query = "SELECT * " +
            "FROM TICKET " +
            "WHERE ticket_number = '" + request.getParameter("Tnum") +"' ";
    pstmt = conn.prepareStatement(query);

    try {
        rs = pstmt.executeQuery();
        if(!rs.next()) {
            System.err.println("Ticket info match fails");
        }
    } catch (SQLException exception) {
        exception.printStackTrace();
        System.exit(1);
    }
    query = "UPDATE TICKET " +
            "SET tcpassport = NULL " +
            "WHERE ticket_number = '" + request.getParameter("Tnum") +"' ";
    try {
        rs = pstmt.executeQuery(query );
        rs = pstmt.executeQuery("commit");
    } catch (SQLException exception) {
        exception.printStackTrace();
        System.exit(1);
    }
    rs.close();
    pstmt.close();
    conn.close();
    response.sendRedirect("/KertAirline/reserve_lookup.jsp");
%>
</body>
</html>
