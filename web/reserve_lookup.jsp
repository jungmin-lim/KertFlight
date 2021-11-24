<%--
  Created by IntelliJ IDEA.
  User: kimdohyun
  Date: 2021-11-20
  Time: 오후 10:59
  메인페이지 -> 예약조회 페이지
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<%
    //    public static final String URL = "jdbc:oracle:thin:@155.230.52.58:16190:xe";
//    public static final String USER_COMPANY = "kertflight";
//    public static final String USER_PASSWD = "kertorkr";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>예약조회</h2>
<p>예약한 정보를 바탕으로 티켓을 확인합니다.</p>
<form action="reserve_list.jsp" method="post">
    <p>특정 대상의 예약 정보 조회하기</p>
    <div>
        <label for="passportID">여권번호</label>
        <input type="text" placeholder="여권번호 입력" name="passportID" id="passportID" required>
    </div>
    <div>
        <label for="passengerName">탑승객 이름</label>
        <input type="text" placeholder="탑승객 이름 입력" name="passengerName" id="passengerName" required>
    </div>
    <div>
        <label for="phoneNumber">전화번호</label>
        <input type="text" placeholder="전화번호 입력" name="phoneNumber" id="phoneNumber" required>
    </div>
    <button type="submit">조회하기</button>
</form>

<form action="reserve_detail.jsp" method="post">
    <p>특정 여정에 대한 예약 정보 조회하기</p>
    <div>
        <label for="passportID2">여권번호</label>
        <input type="text" placeholder="여권번호 입력" name="passportID" id="passportID2" required>
    </div>
    <div>
        <label for="passengerName2">탑승객 이름</label>
        <input type="text" placeholder="탑승객 이름 입력" name="passengerName" id="passengerName2" required>
    </div>
    <div>
        <label for="departureDate">출발일</label>
        <input type="date" placeholder="출발일 입력" name="departureDate" id="departureDate" required>
    </div>
    <button type="submit">조회하기</button>
</form>
</body>
</html>
