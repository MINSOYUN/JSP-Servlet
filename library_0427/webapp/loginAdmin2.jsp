<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "/common/header.jsp" %>
<%
 if(session.getAttribute("member") != null){
	 Member m = (Member)session.getAttribute("member");
%>
<h3>관리자 메뉴 - 사용자 관리</h3>
	<ul>
		<li><a href="../member/list.member">관리자 목록 보기</a></li> 
		<li>관리자등록  <a href="../book/write.book">[바로가기]</a></li> 
		<li>관리자삭제</li>
	</ul>
<% } %>
	<button onclick="location.href='login.jsp'">로그아웃</button>
</body>
</html>