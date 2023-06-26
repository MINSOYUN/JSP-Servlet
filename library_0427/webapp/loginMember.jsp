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
// 세션에 저장된 멤버 객체로부터 아이디를 출력
 if(session.getAttribute("member") != null){
	 Member m = (Member)session.getAttribute("member");
%>
<%= m.getId() %> 님 환영합니다.
	<h3>사용자 메뉴</h3>
	<ul>
	<li>도서 대여</li>
	<li>도서 반납</li>	
	</ul>
	<% } %>
	
	<button onclick="location.href='login.jsp'">로그아웃</button>
</body>
</html>