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
	// 세션 무효화
	// 세션의 기본 유효시간은 30분
	session.invalidate();
%>
세션이 무효화 되었습니다
<!-- 돌아가면 'session에 person 객체가 없습니다' 출력 -->
<a href = "SessionLocation.jsp">SessionLocation.jsp 바로가기</a>

</body>
</html>