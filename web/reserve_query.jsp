<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="java.text.*, java.util.TimeZone, java.sql.*" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>COMP322: Databases</title>
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
    PreparedStatement pstmt;
    ResultSet rs=null;
    try {
        TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
        TimeZone.setDefault(timeZone);
        Class.forName("oracle.jdbc.driver.OracleDriver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }

    try {
        conn = DriverManager.getConnection(url,user,pass);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    conn.setTransactionIsolation(java.sql.Connection.TRANSACTION_READ_COMMITTED);
    conn.setAutoCommit(false);
    String query = "SELECT * " +
            "FROM TICKET " +
            "WHERE ticket_number = '" + request.getParameter("Tnum") +"' "+
            "and tcpassport is null ";
    pstmt = conn.prepareStatement(query);

    try {
        rs = pstmt.executeQuery();
        if(!rs.next()) {
            System.err.println("Ticket info match fails");
            System.exit(1);
        }
    } catch (SQLException exception) {
        exception.printStackTrace();
        System.exit(1);
    }

    query = "SELECT * " +
            "FROM CUSTOMER " +
            "WHERE cpassport_number = '" + request.getParameter("Passportnumber") +"' ";
    pstmt = conn.prepareStatement(query);

    rs = pstmt.executeQuery();
    if(!rs.next()) {
        query = "insert into customer values ('"+ request.getParameter("Passportnumber") + "', '"+ request.getParameter("First_name") + "', '"+ request.getParameter("Last_name") + "', '"+ request.getParameter("Country")+ "', TO_DATE('"+ request.getParameter("Birth_date") + "','yyyy-MM-dd'), '"+ request.getParameter("Gender") + "', '"+request.getParameter("phone_number")+"') " ;
        pstmt = conn.prepareStatement(query);

        try {
            rs = pstmt.executeQuery();
            if(!rs.next()) {
                System.err.println("Ticket info match fails");
            }
        } catch (SQLException exception) {
            exception.printStackTrace();
            System.exit(1);
        }
    }


    query = "update ticket set tcpassport = '"+request.getParameter("Passportnumber")+"' where Ticket_number='"+request.getParameter("Tnum")+"'" ;
    try {
        rs = pstmt.executeQuery(query );
        rs = pstmt.executeQuery("commit");
    } catch (SQLException exception) {
        exception.printStackTrace();
        System.exit(1);
    }
    rs.close();
    pstmt.close();
    conn.close();
    response.sendRedirect("/main.jsp");
%>
</body>
</html>
