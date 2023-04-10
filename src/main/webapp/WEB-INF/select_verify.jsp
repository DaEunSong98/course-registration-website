<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding= "UTF-8"%> 
<%@ page import="java.sql.*"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@include file="top.jsp" %>


<%
Connection myConn = null;      Statement stmt = null;   
CallableStatement cstmt = null;
ResultSet myResultSet = null;   String mySQL = "";
String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1712569";     String passwd="oracle";
String dbdriver = "oracle.jdbc.driver.OracleDriver";    
String s_id=(String)session.getAttribute("session_id");
String e_year=request.getParameter("e_year");
String e_semester=request.getParameter("e_semester");
int i=0;
int sum=0;

%>

</table>
<table width="75%" align="center"  border>
<br>
<tr>
<colspan=6><div align="center">
<%=e_year %>학년도 <%=e_semester %>학기 수강신청 내역입니다
</div></th></tr>
<tr  bgcolor="#FFFF99">
<th>교시</th><th>과목번호</th><th>과목명</th><th>분반</th><th>학점</th><th>장소</th>
</tr>
<% 
try{
   Class.forName(dbdriver);
   myConn =  DriverManager.getConnection (dburl, user, passwd);
   stmt = myConn.createStatement();   
} catch(SQLException ex) {
        System.err.println("SQLException: " + ex.getMessage());
}

cstmt=myConn.prepareCall("{call enroll_sum(?,?,?,?,?)}");
cstmt.setString(1, session_id);
cstmt.setString(2, e_year);
cstmt.setString(3, e_semester);
cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
cstmt.executeUpdate();
i=cstmt.getInt(4);
sum=cstmt.getInt(5);


cstmt = myConn.prepareCall("{call SelectTimeTable_print(?,?,?,?)}");   
cstmt.setString(1, session_id);
cstmt.setString(2, e_year);
cstmt.setString(3, e_semester);
cstmt.registerOutParameter(4, oracle.jdbc.OracleTypes.CURSOR);   
cstmt.execute();
myResultSet=(ResultSet)cstmt.getObject(4);
Boolean isLogin=false;
   while (myResultSet.next()) {  
      int t_time=myResultSet.getInt("c_time");
      String c_id  = myResultSet.getString("c_id");   
      String c_name = myResultSet.getString("c_name");
      int c_id_no=myResultSet.getInt("c_id_no");
      Integer c_unit = myResultSet.getInt("c_unit");
      String c_where=myResultSet.getString("c_place");
      
      %>
  <tr>
   <td align="center"><%= t_time %></td><td align="center"><%= c_id %></td> 
  <td align="center"><%= c_name %></td><td align="center"> <%= c_id_no %></td>
    <td align="center"><%= c_unit %></td><td align="center"> <%= c_where %></td>
</tr>
<%}%>

<tr>
<td align="center" colspan="4">총 신청학점</td>
<td align="center" colspan="2"><%= sum %></td>
</tr>
<tr>
<td align="center" colspan="4" >신청 과목 수</td>
<td align="center" colspan="2"><%= i %></td>
</tr>
</table>

</body>
</html>