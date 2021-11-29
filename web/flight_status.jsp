<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.sql.*, java.util.Date" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>COMP322: Databases</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Constant/css/detail_style.css">
    <div class="navbar">
        <div class="icon">
            <h2 class="logo"><a href="#">KertFlight</h2>
        </div>
        <div class="menu">
            <ul>
                <li><a href="#">BOOK</a></li>
                <li><a href="#">AIRPORT</a></li>
                <li><a href="#">IN-FLIGHT</a></li>
            </ul>
        </div>
    </div>
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
<h2><span style="color:#FFFFFF">비행 현황판</span><span style="color:#8C8C8C">(Currently flying planes)</span></h2>
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
