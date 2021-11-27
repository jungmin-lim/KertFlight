<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>COMP322: Databases</title>
    <link rel="stylesheet" href="{pageContext.request.contextPath}/Constant/css/detail_style.css">
</head>
<body>
<h4>info</h4>
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
<ul><li>티켓 상세 정보<span style="color:#6A6A6A">(Ticket information)</span></li></ul>
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
    }
%>
<td><button class="btn" onclick=location.href="refund.jsp?Tnum=<%=Tnum%>">예약 취소</button></td>
</tr>
</table>
<ul><li>비행 정보<span style="color:#6A6A6A">(Flight information)</span></li></ul>
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
<ul><li>승무원 정보<span style="color:#6A6A6A">(Crew information)</span></li></ul>
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
