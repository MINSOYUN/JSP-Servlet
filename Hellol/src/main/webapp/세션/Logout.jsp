<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 방법1. 세션 삭제
	session.removeAttribute("UserId");
	session.removeAttribute("member");
	
	// 방법2. 세션 무효화
	session.invalidate();
	
	// 페이지이동
	response.sendRedirect("LoginForm.jsp");
	%>
</body>
</html>