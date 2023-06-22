<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>MVC 패턴으로 회원 인증하기</h4>
	
	<p>${authMessage }</p> <!-- message 있다면 출력 -->
	<a href="./MemberAuth.mvc?id=sso&pw=1234">test 로그인</a>
</body>
</html>