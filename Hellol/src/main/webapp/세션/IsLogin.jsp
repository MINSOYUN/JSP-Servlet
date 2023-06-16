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
	if(session.getAttribute("user_id") == null){
%>
	<script>
		alert("로그인 후 이용 가능한 메뉴입니다");
		location.href="../세션/LoginForm.jsp";   // 변경되는 부분만 파라미터로 받는다
	</script>
<%
	}
%>
</body>
</html>