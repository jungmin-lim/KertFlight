<%--
  Created by IntelliJ IDEA.
  User: kimdohyun
  Date: 2021-11-20
  Time: 오후 10:59
  메인페이지 -> 예약조회 페이지
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ page language="java" import="java.text.*, java.sql.*" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Constant/css/reserve_lookup_style.css">
</head>
<body>
    <div class="center">
        <h1>예약조회<span style="color: #6A6A6A">(reserve lookup)</span></h1>
        <p style="color: #6A6A6A; margin: 10px">   예약한 정보를 바탕으로 티켓을 확인합니다.</p>

        <form action="reserve_list.jsp" method="post">
            <p style="color: #6A6A6A">특정 대상의 예약 정보 조회하기</p>
            <div class="txt_field">
                <input type="text" name="passportID" required>
                <span></span>
                <label>여권번호</label>
            </div>
            <div class="txt_field">
                <input type="text" name="passengerLastName" required>
                <span></span>
                <label>탑승객 성</label>
            </div>
            <div class="txt_field">
                <input type="text" name="passengerFirstName" required>
                <span></span>
                <label>탑승객 이름</label>
            </div>
            <div class="txt_field">
                <input type="text" name="phoneNumber" required>
                <span></span>
                <label>전화번호</label>
            </div>
            <input type="submit" value="조회하기">
        </form>

        <form action="reserve_detail.jsp" method="post">
            <p style="color: #6A6A6A">특정 여정에 대한 예약 정보 조회하기</p>
            <div class="txt_field">
                <input type="text" name="ticketNumber" required>
                <span></span>
                <label>티켓번호</label>
            </div>
            <div class="txt_field">
                <input type="text" name="passengerLastName" required>
                <span></span>
                <label >탑승객 성</label>
            </div>
            <div class="txt_field">
                <input type="text" name="passengerFirstName" required>
                <span></span>
                <label>탑승객 이름</label>
            </div>
            <div class="txt_field">
                <input type="date" name="departureDate" required>
                <span></span>
            </div>
            <input type="submit" value="조회하기">
        </form>
    </div>
</body>
</html>
