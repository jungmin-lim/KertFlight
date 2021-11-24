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
</head>
<body>
<h2>예약된 여정 리스트</h2>
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
            out.println(String.format("<div>\n" +
                    "    <p>\n" +
                    "        <strong>티켓번호</strong>\n" +
                    "        <span>%s</span>\n" +
                    "    </p>\n" +
                    "    <p>\n" +
                    "        <strong>티켓 가격</strong>\n" +
                    "        <span>%d 달러</span>\n" +
                    "    </p>\n" +
                    "    <p>\n" +
                    "        <strong>편명</strong>\n" +
                    "        <span>%s</span>\n" +
                    "    </p>\n" +
                    "    <p>\n" +
                    "        <strong>좌석번호</strong>\n" +
                    "        <span>%s</span>\n" +
                    "    </p>\n" +
                    "    <p>\n" +
                    "        <strong>출발</strong>\n" +
                    "        <span>%s(%s)</span>\n" +
                    "    </p>\n" +
                    "    <p>\n" +
                    "        <strong>도착</strong>\n" +
                    "        <span>%s(%s)</span>\n" +
                    "    </p>\n" +
                    "</div>", ticket_number, price, flight_number, seat_id, departure_airport, departure_time, arrival_airport, arrival_time));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<%--<div>--%>
<%--    <p>--%>
<%--        <strong>티켓번호</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        <strong>티켓 가격</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        <strong>편명</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        <strong>좌석번호</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        <strong>출발</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--    <p>--%>
<%--        <strong>도착</strong>--%>
<%--        <span></span>--%>
<%--    </p>--%>
<%--</div>--%>

</body>
</html>
