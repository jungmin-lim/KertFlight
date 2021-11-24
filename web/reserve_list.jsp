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
<%
    String URL = "jdbc:oracle:thin:@155.230.52.58:16190:xe";
    String USER_COMPANY = "kertflight";
    String USER_PASSWD = "kertorkr";
    Connection conn = null;
    PreparedStatement preparedStatement;
    ResultSet resultSet;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(URL, USER_COMPANY, USER_PASSWD);
    String sql;
    ResultSetMetaData resultSetMetaData;
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
    String passengerName = request.getParameter("passengerName");
    String phoneNumber = request.getParameter("phoneNumber");

    sql = "select * from (select * from ticket t where t.tcpassport = '6090JYGV11283') join customer c on tcpassport=c.cpassport_number where 'Alberta'=c.cfirst_name and 'Cowie'=c.clast_name and c.cphone_number='010-3183-2123'";
    preparedStatement = conn.prepareStatement(sql);
    resultSet = preparedStatement.executeQuery();


%>

<div>
    <p>
        <strong>예약일</strong>
        <span>2020-07-30</span>
    </p>
    <p>
        <strong>예약번호</strong>
        <span>1234</span>
    </p>
    <p>
        <strong>출발지</strong>
        <span>대구</span>
    </p>
    <p>
        <strong>도착지</strong>
        <span>서울</span>
    </p>
    <p>
        <strong>탑승자명</strong>
        <span>김도현</span>
    </p>
</div>

</body>
</html>
