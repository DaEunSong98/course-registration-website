<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding= "UTF-8"%> 
<%@ page import="java.sql.*"%> 
<!DOCTYPE html>
<html><head><title>수강신청 입력</title></head>

<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp");  %>

<%
	String s_id = (String) session.getAttribute("user");
	String year = (String) session.getAttribute("year");
	String semester = (String) session.getAttribute("semester");
%>


<table width="75%" align="center" border>
<br>
<tr bgcolor="#FFFF99">
<th>과목번호</th><th>분반</th><th>시간</th><th>정원</th><th>과목명</th><th>학점</th><th>수강신청</th>
</tr>
<form method=post action="insert_verify.jsp">
<%
Connection myConn = null;      Statement stmt = null;   
ResultSet myResultSet = null;   String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1712569";     String passwd="oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
PreparedStatement pstmt = null;

try{
   Class.forName(dbdriver);
   myConn =  DriverManager.getConnection (dburl, user, passwd);
   stmt = myConn.createStatement();   
} catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
}


pstmt = myConn.prepareStatement("select c.c_id, c.c_id_no, c.c_name, c.c_unit, cd.c_time, cd.c_max from course c, course_detail cd where c.c_id=cd.c_id and cd.c_year=? and cd.c_semester=? and c.c_id not in (select c_id from enroll where s_id=? and e_year=? and e_semester=?) ORDER BY c.c_id");
pstmt.setString(1, year);
pstmt.setString(2, semester);
pstmt.setString(3, s_id);
pstmt.setString(4, year);
pstmt.setString(5, semester);
myResultSet = pstmt.executeQuery();


if (myResultSet != null) {
   while (myResultSet.next()) {   
      String c_id = myResultSet.getString("c_id");
      int c_id_no = myResultSet.getInt("c_id_no");
      String ctime =myResultSet.getString("c_time");
      String cmax =myResultSet.getString("c_max");
      String c_name = myResultSet.getString("c_name");
      int c_unit = myResultSet.getInt("c_unit");

%>
<tr>
  <td align="center"><%= c_id %></td> <td align="center"><%= c_id_no %></td> <td align="center"><%= ctime %></td>
  <td align="center"><%= cmax %></td> <td align="center"><%= c_name %></td><td align="center"><%= c_unit %></td>
  <td align="center"><a href="insert_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">신청</a></td>
</tr>
<%    
   }
}

stmt.close();
myConn.close();
%>
</form>
</table>
</body>
</html>  