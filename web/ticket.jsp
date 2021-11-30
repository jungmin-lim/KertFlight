<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.TimeZone, java.util.ArrayList, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Welcome to KertFlight</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Constant/css/ticket.css">
</head>

<body>
    <%
        // Database connection
        String serverIP = "155.230.52.58";
        String strSID = "xe";
        String portNum = "16190";
        String user = "kertflight";
        String pass = "kertorkr";
        String url = "jdbc:oracle:thin:@"+serverIP + ":" + portNum + ":" + strSID;
        String sql = "";
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;

        try{
            TimeZone timeZone = TimeZone.getTimeZone("Asia/Seoul");
            TimeZone.setDefault(timeZone);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, user, pass);
        } catch(ClassNotFoundException e) {
            e.printStackTrace();
            out.println("alert(\"Oracle Driver Class not found\")");
        } catch(SQLException e) {
            e.printStackTrace();
            out.println("alert(\"DBMS Connection Error\")");
        }
    %>
    <div class="main">
        <div class="navbar">
            <div class="icon">
                <h2 class="logo"><a href="${pageContext.request.contextPath}/main.jsp">KertFlight</a></h2>
            </div>
            <div class="menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/flight.jsp">BOOK</a></li>
                    <li><a href="${pageContext.request.contextPath}/reserve_lookup.jsp">TICKETS</a></li>
                    <li><a href="${pageContext.request.contextPath}/flight_status.jsp">IN-FLIGHT</a></li>
                </ul>
            </div>
        </div>
        <div class="content">
            <table>
                <thead>
                    <th>Flight Num.</th>
                    <th>Seat ID</th>
                    <th>Price</th>
                    <th>Class</th>
                    <th>BOOK</th>
                </thead>
                <%
                    String flightNumber = request.getParameter("flightNumber");
                    boolean flag = false;

                    if(flightNumber == null) {
                        flag = false;
                    }
                    else {
                        flag = true;
                    }

                    if (flag) {
                        sql = "SELECT Ticket_number, Tsid, Price, Class " +
                        "   FROM TICKET, SEAT " + 
                        "   WHERE TICKET.Tpid = SEAT.Spid " +
                        "   AND TICKET.Tsid = SEAT.Seat_id " + 
                        "   AND TICKET.Tfnum = \'" + flightNumber + "\' " +
                        "   AND TICKET.Tcpassport IS NULL " +
                        "   ORDER BY Ticket_number";

                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        ArrayList<String> firstClassTicketNumberList = new ArrayList<String> ();
                        ArrayList<String> firstClassSeatIDList = new ArrayList<String> ();
                        double firstClassPrice = 0.0;

                        ArrayList<String> businessClassTicketNumberList = new ArrayList<String> ();
                        ArrayList<String> businessClassSeatIDList = new ArrayList<String> ();
                        double businessClassPrice = 0.0;

                        ArrayList<String> economyClassTicketNumberList = new ArrayList<String> ();
                        ArrayList<String> economyClassSeatIDList = new ArrayList<String> ();
                        double economyClassPrice = 0.0;

                        while(rs.next()) {
                            String ticketNumber = rs.getString(1);
                            String seatID = rs.getString(2);
                            double price = rs.getDouble(3);
                            String className = rs.getString(4);

                            if(className.equals("First")) {
                                firstClassPrice = price;
                                firstClassTicketNumberList.add(ticketNumber);
                                firstClassSeatIDList.add(seatID);
                            }
                            else if (className.equals("Business")) {
                                businessClassPrice = price;
                                businessClassTicketNumberList.add(ticketNumber);
                                businessClassSeatIDList.add(seatID);
                            }
                            else if (className.equals("Economy")) {
                                economyClassPrice = price;
                                economyClassTicketNumberList.add(ticketNumber);
                                economyClassSeatIDList.add(seatID);
                            }
                            else {
                            }
                        }

                        if(firstClassTicketNumberList.size() > 0) {
                            out.println("<FORM ACTION=\"reserve.jsp\" METHOD=GET>");
                            out.println("<tr>");
                            out.println("<td>" + flightNumber + "</td>");
                            out.println("<td><select name=\"TicketNumber\">");
                            for(int idx = 0; idx < firstClassTicketNumberList.size(); ++idx) {
                                out.println("<option value=\"" + firstClassTicketNumberList.get(idx) + "\">" + firstClassSeatIDList.get(idx) + "</option>");
                            }
                            out.println("</select></td>");
                            out.println("<td>" + firstClassPrice + "</td>");
                            out.println("<td>First</td>");
                            out.println("<td><input type=submit class=\"btn\" value=\"BOOK\"></input></td>");
                            out.println("</tr>");
                            out.println("</FORM>");
                        }

                        if(businessClassTicketNumberList.size() > 0) {
                            out.println("<FORM ACTION=\"reserve.jsp\" METHOD=GET>");
                            out.println("<tr>");
                            out.println("<td>" + flightNumber + "</td>");
                            out.println("<td><select name=\"TicketNumber\">");
                            for(int idx = 0; idx < businessClassTicketNumberList.size(); ++idx) {
                                out.println("<option value=\"" + businessClassTicketNumberList.get(idx) + "\">" + businessClassSeatIDList.get(idx) + "</option>");
                            }
                            out.println("</select></td>");
                            out.println("<td>" + businessClassPrice + "</td>");
                            out.println("<td>Business</td>");
                            out.println("<td><input type=submit class=\"btn\" value=\"BOOK\"></input></td>");
                            out.println("</tr>");
                            out.println("</FORM>");
                        }

                        if(economyClassTicketNumberList.size() > 0) {
                            out.println("<FORM ACTION=\"reserve.jsp\" METHOD=GET>");
                            out.println("<tr>");
                            out.println("<td>" + flightNumber + "</td>");
                            out.println("<td><select name=\"TicketNumber\">");
                            for(int idx = 0; idx < economyClassTicketNumberList.size(); ++idx) {
                                out.println("<option value=\"" + economyClassTicketNumberList.get(idx) + "\">" + economyClassSeatIDList.get(idx) + "</option>");
                            }
                            out.println("</select></td>");
                            out.println("<td>" + economyClassPrice + "</td>");
                            out.println("<td>Economy</td>");
                            out.println("<td><input type=submit class=\"btn\" value=\"BOOK\"></input></td>");
                            out.println("</tr>");
                            out.println("</FORM>");
                        }

                    }
                %>
            </table>
        </div>
    </div>
</body>