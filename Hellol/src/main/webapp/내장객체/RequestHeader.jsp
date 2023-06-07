<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Enumeration" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - request</title>
</head>
<body>
	<h2>3. HTTP 요청 헤더 정보 출력하기</h2>
	<% 
	// Enumeration: 객체들을 집합체 형태로 관리하게 해주는 인터페이스
	// Iterator
	// 컬렉션에서 사용된다
	// list, set, map
	Enumeration headers = request.getHeaderNames();
	
	// = Next()
	while(headers.hasMoreElements()){   // 다음 헤더가 존재하면 true 반환
		String headerName = (String)headers.nextElement();    // 오브젝트 타입 -> String 으로 형변환   헤더 이름가져오고
		String headerValue = request.getHeader(headerName);  // 헤더의값을 가져온다
		
		out.print("헤더명: "+ headerName + " 헤더값: "+headerValue +"<br>");
	}
	%>
	<!--  어떤 페이지에서 현재 요청을 발생시킨 것인지를 나타내는 HTTP 헤더 -->
	<p>이 파일을 직접 실행하면 referrer 정보는 출력되지 않는다 </p>
</body>
</html>