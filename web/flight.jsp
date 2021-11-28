<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- import JDBC package -->
<%@ page language="java" import="java.text.*, java.sql.*, java.util.TimeZone, java.util.ArrayList, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Welcome to KertFlight</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Constant/css/flight.css">
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
                    <th>Departure Airport</th>
                    <th>Arrival Airport</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Plane Model</th>
                    <th>BOOK</th>
                </thead>
                <%
                    String deptAirport = request.getParameter("deptA");
                    String arrivAirport = request.getParameter("arrivA");
                    String deptDate = request.getParameter("deptdate");
                    Boolean flag = false;

                    if((deptAirport == null) || (arrivAirport == null) || (deptDate == null)) {
                        flag = false;
                    }
                    else {
                        flag = true;
                    }

                    if (flag) {
                        

                        sql = "SELECT Flight_number, Departure_airport, Arrival_airport, Departure_time, Arrival_time, Model_name " +
                        "   FROM FLIGHT, PLANE " + 
                        "   WHERE FLIGHT.Fpid = PLANE.Plane_id " +
                        "   AND FLIGHT.Arrival_airport = \'" + arrivAirport + "\' " +
                        "   AND FLIGHT.Departure_airport = \'" + deptAirport + "\' " +
                        "   AND to_char(FLIGHT.Departure_time, \'YYYY-MM-DD\') = \'" + deptDate +"\'";

                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                        while(rs.next()) {
                            String flightNumber = rs.getString(1);
                            String departureAirport = rs.getString(2);
                            String arrivalAirport = rs.getString(3);
                            String departureTime = rs.getString(4);
                            String arrivalTime = rs.getString(5);
                            String modelName = rs.getString(6);

                            out.println("<tr>");
                            out.println("<td>" + flightNumber + "</td>");
                            out.println("<td>" + departureAirport + "</td>");
                            out.println("<td>" + arrivalAirport + "</td>");
                            out.println("<td>" + departureTime + "</td>");
                            out.println("<td>" + arrivalTime + "</td>");
                            out.println("<td>" + modelName + "</td>");
                            out.println("<td><button class=\"btn\" onclick=\"location.href=\'ticket.jsp?flightNumber=" + flightNumber + "\'\">Book</button></td>");
                            out.println("</tr>");
                        }
                    }
                %>
            </table>
        </div>
        <div class="form">
            <% 
               sql = "SELECT airport_code, airport_name " +
                "   FROM AIRPORT " +
                "   ORDER BY airport_code";

                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                ArrayList<String> airportCodeList = new ArrayList<String>(); 
                ArrayList<String> airportNameList = new ArrayList<String>();
                while(rs.next()) {
                    airportCodeList.add(rs.getString(1));
                    airportNameList.add(rs.getString(2));
                }

                assert airportCodeList.size() == airportNameList.size();
                int airportListSize = airportCodeList.size();

                out.println("<FORM ACTION=\"flight.jsp\" METHOD=GET>");

                // selection box for departing airport
                out.println("<div class=\"select-info\">Departure :   ");
                out.println("<select name=\"deptA\">");
                for(int idx = 0; idx < airportListSize; ++idx) {
                    String airportCode = airportCodeList.get(idx);
                    String airportName = airportNameList.get(idx);
                    out.println("<option value=\"" + airportCode + "\">" + airportCode + " : " + airportName + "</option>");
                }
                out.println("</select>");
                out.println("</div>");

                // selection box for arriving airport
                out.println("<div class=\"select-info\">Arrival :   ");
                out.println("<select name=\"arrivA\">");
                for(int idx = 0; idx < airportListSize; ++idx) {
                    String airportCode = airportCodeList.get(idx);
                    String airportName = airportNameList.get(idx);
                    out.println("<option value=\"" + airportCode + "\">" + airportCode + " : " + airportName + "</option>");
                }
                out.println("</select>");
                out.println("</div>");

                // departure date selection
                Date currentDate = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                out.println("<div class=\"date-select-box\">");
                out.println("<input type=\"date\" class=\"datechk\" id=\"deptdate\" name=\"deptdate\" min=\"" + formatter.format(currentDate) + "\" " +
                    "style=\"position:relative; margin-left: 4px; margin-right:4px; border-width: 0px; border-style: none; background: #2f3640; color: #f5f6fa; font-size:16px; height:42px; border-radius:8px; overflow:hidden;\"></input>");
                out.println("</div>");

                // search button
                out.println("<div class=\"search-button\">");
                out.println("<input type=submit value=\"search\"></input>");
                out.println("</div>");

                out.println("</FORM>");           
            %>
        </div>
    </div>
</body>