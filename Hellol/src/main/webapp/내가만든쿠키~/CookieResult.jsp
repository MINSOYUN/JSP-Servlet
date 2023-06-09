<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 값 출력</title>
</head>
<body>
	<!-- 쿠키는 헤더에 넘어오고 헤더에 저장 -->
	<h3>쿠키 값 확인하기</h3>
	<p>처음 접속시 저장된 쿠키가 없는 경우 빈페이지가 출력 될 수 있습니다</p>
	<%
	// 출력하기 위해선 배열 -> 변수에 담기
	Cookie[] cookies= request.getCookies(); // 요청 -> request로부터 가져온다
	if(cookies != null){
		for(Cookie cookie: cookies){
			String cookieName = cookie.getName();  // 이름
			String cookieValue = cookie.getValue(); // value
			out.print("쿠키명: "+cookieName+"<br>"+ "쿠키값: "+cookieValue+"<br><br>");
		}
	}
	%>
</body>
</html>