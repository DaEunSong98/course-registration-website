<%@ page language= "java" contentType ="text/html; charset=UTF-8" pageEncoding ="UTF-8"%> 
<%@ page import= "java.sql.*"%>
<html><head><title>수강신청 삭제</title></head>
<body>

<%
	String s_id = (String) session.getAttribute("user");
	String c_id = request.getParameter("c_id");
	String year = (String) session.getAttribute("year");
	String semester = (String) session.getAttribute("semester");
%>

<%
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
String user = "db1712569"; 
String password = "oracle"; // Oracle 본인 계정 password 입력 

Connection myConn=null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs=null;
String sql;

try
{
	Class.forName(driver);
	myConn = DriverManager.getConnection(url, user, password);
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: "+ex.getMessage());
}

if(c_id == null)
{
	%>
	<script>   
	alert("잘못된 요청입니다.");   
	location.href="delete.jsp"; 
	</script>
	<%
}

pstmt = myConn.prepareStatement("delete From enroll where s_id = ? and c_id = ? and e_year = ? and e_semester = ?");
pstmt.setString(1, s_id);
pstmt.setString(2, c_id);
pstmt.setString(3, year);
pstmt.setString(4, semester);
pstmt.executeUpdate();

%>
<script>   
alert("수강신청이 취소 되었습니다.");   
location.href="delete.jsp"; 
</script>

<%
stmt.close();
pstmt.close();
myConn.close(); 
%>

</body>
</html>