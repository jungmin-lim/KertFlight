<%--
  Created by IntelliJ IDEA.
  User: kimdohyun
  Date: 2021-11-22
  Time: 오후 8:28
  메인페이지 -> 예약조회 페이지 -> 예약리스트 페이지
  특정 대상의 예약된 여정 전부를 보여줌.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%@ page import="java.util.TimeZone" %>
<%
    String URL = "jdbc:oracle:thin:@155.230.52.58:16190:xe";
    String USER_COMPANY = "kertflight";
    String USER_PASSWD = "kertorkr";
    TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
    TimeZone.setDefault(timeZone);
    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(URL, USER_COMPANY, USER_PASSWD);
    ResultSetMetaData rsmt;
    int cnt;
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Constant/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Constant/css/detail_style.css">
</head>
<body>
<div>
    <div class="navbar">
        <div class="icon">
            <h2 class="logo"><a href="#">KertFlight</a></h2>
        </div>
        <div class="menu">
            <ul>
                <li><a href="#">BOOK</a></li>
                <li><a href="#">AIRPORT</a></li>
                <li><a href="#">IN-FLIGHT</a></li>
            </ul>
        </div>
    </div>

    <h3>예약된 티켓 리스트<br><span style="color:#6A6A6A">(Reserved Ticket List)</span></h3>

    <table>
        <thead>
        <th>티켓 번호<br><span style="color:#6A6A6A">(Ticket Number)</span></th>
        <th>가격<br><span style="color:#6A6A6A">(Price)</span></th>
        <th>비행 번호<br><span style="color:#6A6A6A">(Flight Number)</span></th>
        <th>좌석 번호<br><span style="color:#6A6A6A">(Seat Number)</span></th>
        <th>출발<br><span style="color:#6A6A6A">(Departure)</span></th>
        <th>도착<br><span style="color:#6A6A6A">(Arrival)</span></th>
        <th>상세보기<br><span style="color:#6A6A6A">(details)</span></th>
        </thead>
        <%
            String passportID = request.getParameter("passportID");
            String passengerLastName = request.getParameter("passengerLastName");
            String passengerFirstName = request.getParameter("passengerFirstName");
            String phoneNumber = request.getParameter("phoneNumber");


            String sql = "select ticket_number, price, tfnum flight_number, tsid seat_id, departure_time, arrival_time, departure_airport, arrival_airport " +
                         "from (ticket t join flight f on t.tfnum = f.flight_number) join customer c on t.tcpassport = c.cpassport_number " +
                         "where c.cpassport_number = '" + passportID + "' " +
                         "and c.cfirst_name = '" + passengerFirstName + "' " +
                         "and c.clast_name = '" + passengerLastName + "' " +
                         "and c.cphone_number = '" + phoneNumber + "' " +
                         "order by f.departure_time";
            try {
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while (rs.next()) {
                    String ticket_number = rs.getString(1);
                    int price = rs.getInt(2);
                    String flight_number = rs.getString(3);
                    String seat_id = rs.getString(4);
                    String departure_time = rs.getString(5);
                    String arrival_time = rs.getString(6);
                    String departure_airport = rs.getString(7);
                    String arrival_airport = rs.getString(8);

                    String onClickStr = String.format("location.href=\"reserve_detail.jsp?ticketNumber=%s&passengerFirstName=%s&passengerLastName=%s&departureDate=%s\"", ticket_number, passengerFirstName, passengerLastName, departure_time.substring(0, 10));

                    out.println(String.format("      <tr>\n" +
                          "<td>%s</td>\n" +
                          "<td>$%d</td>\n" +
                          "<td>%s</td>\n" +
                          "<td>%s</td>\n" +
                          "<td>%s<br>%s</td>\n" +
                          "<td>%s<br>%s</td>\n" +
                          "<td><button class=\"btn\" onclick="+onClickStr+">상세보기<br><span>(details)</span></button></td>\n" +
                          "</tr>", ticket_number, price, flight_number, seat_id, departure_airport, departure_time, arrival_airport, arrival_time));
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>

    <%--    <table>--%>
    <%--        <thead>--%>
    <%--        <th>티켓 번호<br><span style="color:#6A6A6A">(Ticket Number)</span></th>--%>
    <%--        <th>가격<br><span style="color:#6A6A6A">(Price)</span></th>--%>
    <%--        <th>비행 번호<br><span style="color:#6A6A6A">(Flight Number)</span></th>--%>
    <%--        <th>좌석 번호<br><span style="color:#6A6A6A">(Seat Number)</span></th>--%>
    <%--        <th>출발<br><span style="color:#6A6A6A">(Departure)</span></th>--%>
    <%--        <th>도착<br><span style="color:#6A6A6A">(Arrival)</span></th>--%>
    <%--        <th></th>--%>
    <%--        </thead>--%>
    <%--        <tr>--%>
    <%--            <td>%s</td>--%>
    <%--            <td>$%d</td>--%>
    <%--            <td>%s</td>--%>
    <%--            <td>%s</td>--%>
    <%--            <td>%s(%s)</td>--%>
    <%--            <td>%s(%s)</td>--%>
    <%--            <td><button class="btn" onclick="">상세보기<br><span>(details)</span></button></td>--%>
    <%--        </tr>--%>
    <%--    </table>--%>

</div>
</body>
</html>
