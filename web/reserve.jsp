<%--
  Created by IntelliJ IDEA.
  User: gyuhwan
  Date: 2021-11-26
  Time: 오후 7:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Ticket reservation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Constant/css/reserve_style.css">
</head>
<body>
<div class="center">
    <h1>티켓예매<span style="color:#6A6A6A">(Reserve ticket)</span></h1>
    <form action="reserve_query.jsp?Tnum="<%=request.getParameter("TicketNumber")%> method="post">
        <div class="txt_field">
            <input type="text" name="phone_number" required>
            <span></span>
            <label>Phone number</label>
        </div>
        <div class="txt_field">
            <input type="text" name="First_name" required>
            <span></span>
            <label>First name</label>
        </div>
        <div class="txt_field">
            <input type="text" name="Last_name" required>
            <span></span>
            <label>Last name</label>
        </div>
        <div class="txt_field">
            <input type="text" name="Birth_date" required>
            <span></span>
            <label>Birth date</label>
        </div>
        <div class="txt_field">
            <input type="text" name="Country" required>
            <span></span>
            <label>Country</label>
        </div>
        <div class="txt_field">
            <input type="text" name="Gender" required>
            <span></span>
            <label>Gender</label>
        </div>
        <div class="txt_field">
            <input type="text" name="Passportnumber" required>
            <span></span>
            <label>Passport number</label>
        </div>
        <input type="submit" value="Reserve">
    </form>
</div>

</body>
</html>