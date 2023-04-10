<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding= "UTF-8"%> 
<%@page import="java.sql.*"%> 
<html> 
<head><title> 수강신청 사용자 정보 수정 </title></head> 
<body>
<% 

String session_id = (String) session.getAttribute("user"); 
String userID=session_id;
request.setCharacterEncoding("utf-8");
String dbdriver="oracle.jdbc.driver.OracleDriver";
String dburl="jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1712569";
String passwd="oracle";
Class.forName(dbdriver);
Connection myConn=null;
String newuserPassword = request.getParameter("newuserPassword");
String newuserPassword2 = request.getParameter("newuserPassword2");
String user_phone = request.getParameter("user_phone");
String user_email = request.getParameter("user_email");
String a="없습니다";
%>
<% 
try{
	 System.out.println("시작");
	 System.out.println(userID);
	 if(user_email.equals(a)){
		 user_email=null;
	 }
	 if(user_phone.equals(a)){
		 user_phone=null;
	 }
	 myConn = DriverManager.getConnection(dburl, user, passwd);
	 Statement stmts_2=myConn.createStatement();
	 String sql = "UPDATE student SET s_pwd=?, s_phone=?, s_email=?   WHERE s_id=?";      
	 PreparedStatement stmt_2 = myConn.prepareStatement(sql);
	 stmt_2.setString(1, newuserPassword);
	 stmt_2.setString(2, user_phone);
	 stmt_2.setString(3, user_email);
	 stmt_2.setString(4, userID);
	 stmt_2.executeUpdate();
	 
	 if(newuserPassword.equals(newuserPassword2)){
		System.out.println("비번 if");
		 %><script> alert("성공적으로 수정했습니다."); location.href="main.jsp";  </script><%
	 }
	 else{
		System.out.println("비번 else");
		 %><script> alert("비밀번호를 다시 확인해주세요."); location.href="update.jsp";  </script><%
	 }
		 
	 
 } 
 catch(SQLException ex) { 
	 String sMessage; 
	 if (ex.getErrorCode()==20002) 
		 sMessage="암호는 4자리 이상이어야 합니다"; 
	 else if (ex.getErrorCode()==20003) 
		 sMessage="암호에 공란은 입력되지 않습니 다."; 
	 else 
		 sMessage="잠시 후 다시 시도하십시오"; 
	 out.println("<script>");

		out.println("alert('"+sMessage+"');");
		out.println("location.href='update.jsp';");
		out.println("</script>");
 }
%>
	
	 </body></html>