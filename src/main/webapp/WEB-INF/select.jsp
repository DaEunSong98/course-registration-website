<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding= "UTF-8"%> 
<%@ page import="java.sql.*"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
</head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp");  %>

<form method=post action="select_verify.jsp">


<table border=1 align="center">
<br>
<tr>
<colspan=2><div align="center">
수강신청 조회 시 다음을 선택해주세요
</div></th></tr>

<tr>
<th><label for=e_year>수강 년도</label>
<select id=e_year name=e_year required>
<option value="2020" selected>2020학년도
<option value="2019" >2019학년도
<option value="2018" >2018학년도
</select>


<th><label for=e_semester>수강 학기</label>
<select id=e_semester name=e_semester required>
<option value="2" selected>2학기
<option value="1" >1학기
</select>
<th><INPUT TYPE="SUBMIT" NAME="Submit" VALUE="확인"> </th>
</tr>
</table>
</form>
</body>
</html>