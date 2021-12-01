<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>reserve detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Constant/css/detail_style.css">
    <div class="navbar">
        <div class="icon">
            <h2 class="logo"><a href="#">KertFlight</h2>
        </div>
        <div class="menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/flight.jsp">BOOK</a></li>
                <li><a href="${pageContext.request.contextPath}/reserve_lookup.jsp">TICKETS</a></li>
                <li><a href="${pageContext.request.contextPath}/flight_status.jsp">IN-FLIGHT</a></li>
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
    String Fnum = "";
    String Tnum = "";
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
<h2><span style="color:#FFFFFF">티켓 상세 정보</span><span style="color:#8C8C8C">(Ticket information)</span></h2>
<%
    String query = "select ticket_number, price, tfnum, tcpassport, teid, tpid, tsid " +
            "from (ticket t join flight f on t.tfnum = f.flight_number) join customer c on t.tcpassport = c.cpassport_number " +
            "where t.ticket_number = '" + request.getParameter("ticketNumber") + "' " +
            "and c.cfirst_name = '" + request.getParameter("passengerFirstName") + "' " +
            "and c.clast_name = '" + request.getParameter("passengerLastName") + "' " +
            "and trunc(departure_time) = TO_DATE('" + request.getParameter("departureDate") + "', 'YYYY-MM-DD')";

    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();


    out.println("<table> <thead>");
    out.println("<th>티켓 번호<br><span style=\"color:#6A6A6A\">(Ticket number)</span></th>");
    out.println("<th>가격<br><span style=\"color:#6A6A6A\">(Price)</span></th>");
    out.println("<th>비행 번호<br><span style=\"color:#6A6A6A\">(Flight number)</span></th>");
    out.println("<th>예약자 여권 번호<br><span style=\"color:#6A6A6A\">(Passport number of customer)</span></th>");
    out.println("<th>담당직원 번호<br><span style=\"color:#6A6A6A\">(Employee number who's in charge of ticket)</span></th>");
    out.println("<th>비행기 번호<br><span style=\"color:#6A6A6A\">(Plane number)</span></th>");
    out.println("<th>좌석 번호<br><span style=\"color:#6A6A6A\">(Seat number)</span></th>");
    out.println("<th>예약 취소<br><span style=\"color:#6A6A6A\">(Refund Ticket)</span></th>");

    out.println("</thead>");
    out.println("<tr>");
    while (rs.next()) {
        out.println("<td>" + rs.getString(1) + "</td>");
        Tnum=rs.getString(1);
        out.println("<td>" + rs.getString(2) + "</td>");
        out.println("<td>" + rs.getString(3) + "</td>");
        Fnum=rs.getString(3);
        out.println("<td>" + rs.getString(4) + "</td>");
        out.println("<td>" + rs.getString(5) + "</td>");
        out.println("<td>" + rs.getString(6) + "</td>");
        out.println("<td>" + rs.getString(7) + "</td>");
        out.println("<td><button class=\"btn\" onclick=location.href=\"refund.jsp?Tnum=" +Tnum+"\">예약 취소</button></td>");
    }
%>
</tr>
</table>
<h2><span style="color:#FFFFFF">비행 정보</span><span style="color:#8C8C8C">(Flight information)</span></h2>
<%
    query = "select * from flight where flight_number='"+Fnum+"' ";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    out.println("<table> <thead>");
    out.println("<th>비행 번호<span style=\"color:#6A6A6A\">(Flight number)</span></th>");
    out.println("<th>도착 시간<span style=\"color:#6A6A6A\">(Arrival time)</span></th>");
    out.println("<th>출발 시간<span style=\"color:#6A6A6A\">(Departure time)</span></th>");
    out.println("<th>기체 번호<span style=\"color:#6A6A6A\">(Plane id)</span></th>");
    out.println("<th>출발 공항<span style=\"color:#6A6A6A\">(Departure airport)</span></th>");
    out.println("<th>도착 공항<span style=\"color:#6A6A6A\">(Arrival airport)</span></th>");
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

    out.println("</tr>");
    out.println("</table>");
%>
<h2><span style="color:#FFFFFF">승무원 정보</span><span style="color:#8C8C8C">(Crew information)</span></h2>
<%
    query = "select  Role, count (*) " +
            "from  FLIGHT, RUN " +
            "where  Flight_number='"+Fnum+"'  and RFid=Flight_number " +
            "group by  Role " +
            "order by  Role ";
    pstmt = conn.prepareStatement(query);
    rs = pstmt.executeQuery();

    out.println("<table> <thead>");
    out.println("<th>직책<span style=\"color:#6A6A6A\">(Role)</span></th>");
    out.println("<th>직원 수<span style=\"color:#6A6A6A\">(Count)</span></th>");
    out.println("</thead>");
    while (rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString(1) + "</td>");
        out.println("<td>" + rs.getFloat(2) + "</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
    conn.close();
%>
</body>
</html>
