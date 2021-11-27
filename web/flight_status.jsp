<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>COMP322: Databases</title>
    <link rel="stylesheet" href="detail_style.css">
</head>
<body>
<h4>info</h4>
<%
    String serverIP = "127.0.0.1";
    String strSID = "orcl";
    String portNum = "1521";
    String user = "kertairline";
    String pass = "123";
    String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
    Connection conn = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date now = new Date();
    String now_dt = sdf.format(now);

    PreparedStatement pstmt;
    ResultSet rs;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    try {
        conn = DriverManager.getConnection(url,user,pass);
    } catch (SQLException e) {
        e.printStackTrace();
    }

%>
<ul><li>비행 현황판<span style="color:#6A6A6A">(Currently flying planes)</span></li></ul>
<%
    String query = "select flight_number, departure_time, arrival_time, fpid, departure_airport, arrival_airport " +
            "from flight " +
            "where departure_time<= to_date('"+now_dt+"','yyyy-mm-dd')"+
            "and arrival_time>=to_date('"+now_dt+"','yyyy-mm-dd')";

    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();


    out.println("<table> <thead>");
    out.println("<th>비행 번호<br><span style=\"color:#6A6A6A\">(Flight number)</span></th>");
    out.println("<th>출발 날짜<br><span style=\"color:#6A6A6A\">(Departure time)</span></th>");
    out.println("<th>도착 날짜<br><span style=\"color:#6A6A6A\">(Arrival time)</span></th>");
    out.println("<th>기체 번호<br><span style=\"color:#6A6A6A\">(Plane id)</span></th>");
    out.println("<th>출발 공항<br><span style=\"color:#6A6A6A\">(Departure airport)</span></th>");
    out.println("<th>도착 공항<br><span style=\"color:#6A6A6A\">(Arrival airport)</span></th>");

    out.println("</thead>");
    out.println("<tr>");
    while (rs.next()) {
        out.println("<td>" + rs.getString(1) + "</td>");
        out.println("<td>" + rs.getDate(2) + "</td>");
        out.println("<td>" + rs.getDate(3) + "</td>");
        out.println("<td>" + rs.getString(4) + "</td>");
        out.println("<td>" + rs.getString(5) + "</td>");
        out.println("<td>" + rs.getString(6) + "</td>");
    }
    rs.close();
    pstmt.close();
    conn.close();
%>
</tr>
</table>
</body>
</html>