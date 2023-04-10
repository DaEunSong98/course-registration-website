<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding= "UTF-8"%> 
<%@page import="java.sql.*"%> 
<html> 
<head><title>수강신청 사용자 정보 수정</title></head> 
<body> 
<%@ include file="top.jsp"%> 

<% 
request.setCharacterEncoding("utf-8");
String userID = request.getParameter("userID"); 
String userPassword = request.getParameter("userPassword"); 
String dbdriver="oracle.jdbc.driver.OracleDriver";
String dburl="jdbc:oracle:thin:@localhost:1521:orcl";
String user="db1712569";
String passwd="oracle";
Class.forName(dbdriver);
Connection myConn=null;
String mySQL3 =null;
String user_email = "";
String user_phone = null;
String user_major = null;
String user_name = null;
ResultSet rss=null;
%>

<%
if (session_id ==null){ 
    out.println("<script>");
      out.println("alert('로그인 후 사용해주세요');");
      out.println("location.href='login.jsp';");
      out.println("</script>");
   }

else{ 
   
   myConn=DriverManager.getConnection(dburl, user, passwd);
   mySQL3="select s_name,s_major,NVL(s_phone,'없습니다')s_phone,NVL(s_email,'없습니다')s_email from student where s_id='" + session_id + "'";
   Statement stmts=myConn.createStatement();
   rss=stmts.executeQuery(mySQL3);
   System.out.println("시작");
   if(rss.next()){
   System.out.println(userPassword);
   user_name=rss.getString("s_name");
   user_major= rss.getString("s_major");
   user_phone= rss.getString("s_phone");
   user_email= rss.getString("s_email");
}
}
%>
<form method= "post" action="update_verify.jsp"> 
<table width= "75%" align="center" bgcolor ="#FFFF99" border> 
<tr> <td><div align= "center"> 사용자 정보를 수정하세요. 
</div></td> </table> 
<table width= "75%" align="center" border>

<tr> 
<td><div align= "center"> 아이디 </div></td> 
<td><div align= "center"> 
<input type="text" name="userID"  value="<%=session_id%>" disabled>>
</div></td> 
</tr>

<tr> 
<td><div align= "center"> 아이디 </div></td> 
<td><div align= "center"> 
<input type="text" name="userID"  value="<%=user_name%>" disabled>>
</div></td> 
</tr>

<tr> 
<td><div align= "center"> 전공 </div></td> 
<td><div align= "center"> 
<input type="text" name="userID"  value="<%=user_major%>" disabled>>
</div></td> 
</tr>


<tr> 
<td><div align= "center"> 패스워드   </div></td> 
<td><div align= "center"> 
<input type= "password" name="newuserPassword"> 
</div></td></tr> 
<tr> 
<td><div align= "center"> 패스워드 확인   </div></td> 
<td><div align= "center"> 
<input type= "password" name="newuserPassword2"> 
</div></td></tr> 
<tr> 
<td><div align= "center"> 전화번호 </div></td> 
<td><div align= "center"> 
<input type= "text" name="user_phone" value="<%=user_phone%>"> 
</div></td> 
</tr>

<tr> 
<td><div align= "center"> 이메일</div></td> 
<td><div align= "center"> 
<input type= "text" name="user_email" value="<%=user_email%>"> 
</div></td> 
</tr>



<tr> 
<td colspan= 3><div align="center"> 
<INPUT TYPE= "SUBMIT" NAME="Submit" VALUE=" 수정완료 "> 
<INPUT TYPE= "RESET" VALUE=" 취소 "> 
<b><a href =" main.jsp "> 메인화면</b></td> 
</div></td></tr> 
</form> 
</body></html>