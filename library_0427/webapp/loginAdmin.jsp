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
	<h3>관리자 메뉴</h3>
	<ul>
	<li>도서등록</li>
	<li>도서삭제 - 도서 상세보기 삭제 버튼을 이용하세요</li>
	<li>관리자등록</li>
	<li>관리자삭제</li>
	</ul>
<% } %>
		<button onclick="location.href='login.jsp'">로그아웃</button>

</body>
</html>