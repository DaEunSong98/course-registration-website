
<%@ page language= "java" contentType ="text/html; charset=UTF-8" pageEncoding ="UTF-8"%> 
<%@ page import= "java.sql.*"%>
<html><head><title>수강신청 삭제</title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp");  %>


<table width="75%" align="center" border>
<br>
<tr>
<th>과목번호</th>
<th>분반</th>
<th>과목명</th>
<th>학점</th>
<th>수강신청 삭제</th>
</tr>

<% 


String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
String user = "db1712569"; 
String password = "oracle"; // Oracle 본인 계정 password 입력 

Connection myConn=null;
Statement stmt = null;
PreparedStatement pstmt = null;
CallableStatement cstmt = null;
ResultSet rs=null;
ResultSet dateRs=null;
String sql;
String year = (String) session.getAttribute("year");
String semester = (String) session.getAttribute("semester");
int month=0;
int sum=0;
int i=0;

try
{
	Class.forName(driver);
	myConn = DriverManager.getConnection(url, user, password); 
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: "+ex.getMessage());
}



pstmt = myConn.prepareStatement("select c_id, c_id_no, c_name, c_unit from course where c_id in (select c_id from ENROLL where s_id=? and e_year=? and e_semester=?)"); //수강학기와 년도 넣어야할까
pstmt.setString(1, session_id);
pstmt.setString(2, year);
pstmt.setString(3, semester);
rs = pstmt.executeQuery();

cstmt=myConn.prepareCall("{call enroll_sum(?,?,?,?,?)}");
cstmt.setString(1, session_id);
cstmt.setString(2, year);
cstmt.setString(3, semester);
cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
cstmt.executeUpdate();
i=cstmt.getInt(4);
sum=cstmt.getInt(5);


if (rs != null) {
	while (rs.next()) {	
		String c_id = rs.getString("c_id");
		int c_id_no = rs.getInt("c_id_no");
		String c_name = rs.getString("c_name");
		int c_unit = rs.getInt("c_unit");
%>
<tr>
  <td align="center"><%= c_id %></td> 
  <td align="center"><%= c_id_no %></td> 
  <td align="center"><%= c_name %></td>
  <td align="center"><%= c_unit %></td>
  <td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%= c_id_no %>">삭제</a></td>
</tr>
<%
		}
	}
%>
<tr>
<th align="center" colspan="4">총 신청학점</th>
<th align="center"><%= sum %></th>
</tr>
<tr>
<th align="center" colspan="4">신청 과목 수</th>
<th align="center" width="30%"><%= i %></th>
</tr>
</table>

<%
stmt.close();
pstmt.close();
cstmt.close();
myConn.close(); 
%>
</body></html>
