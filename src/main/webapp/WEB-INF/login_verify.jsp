<%@ page language= "java" contentType ="text/html; charset=UTF-8" pageEncoding ="UTF-8"%> 
<%@ page import= "java.sql.*"%> 
<% 
String userID=request.getParameter("userID"); 
String userPassword=request.getParameter("userPassword");
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:orcl"; 
String user = "db1712569"; 
String password = "oracle"; // Oracle 본인 계정 password 입력 

Connection myConn=null;
Statement stmt = null;
ResultSet rs=null;
String sql;
ResultSet dateRs=null;
String year;
String semester;
int month=0;

try
{
	Class.forName(driver);
	myConn = DriverManager.getConnection(url, user, password); 
	stmt = myConn.createStatement();
} catch(SQLException ex){
	System.err.println("SQLException: "+ex.getMessage());
}

sql="SELECT TO_CHAR(SYSDATE, 'yyyy') y, TO_CHAR(SYSDATE, 'mm') m FROM DUAL";
dateRs=stmt.executeQuery(sql);
dateRs.next();
year=dateRs.getString("y");
month=Integer.parseInt(dateRs.getString("m"));

if(month>=5 && month <=10)
{
	semester="2";
}
else
	semester="1";

session.setAttribute("year", year);
session.setAttribute("semester", semester);

String sqls="create or replace view studentss(s_id,s_pwd) as select s_id,s_pwd from student";
stmt.executeQuery(sqls);

sql="select s_id from student where s_id='"+ userID +"' and s_pwd= '"+userPassword+"'";
rs=stmt.executeQuery(sql);

if (rs.next()) 
{
	session.setAttribute("user", userID);
	response.sendRedirect("main.jsp");
}

else 
{
%>
	<script>   
	alert("아이디와 패스워드가 올바르지 않습니다.");   
	location.href="login.jsp"; 
	</script>
<%
}

stmt.close(); 
myConn.close(); 
%>