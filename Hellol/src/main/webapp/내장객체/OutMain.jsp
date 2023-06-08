<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	out 객체
	웹 브라우저에 변수 등의 값을 출력 할 때 사용
	스크립틀릿 (< % 자바코드 % >) 내부에서 변수등을 출력하기 위해서 사용
 -->
 <%
 	// 버퍼 내용 삭제하기
 	out.clearBuffer();  // 버퍼를 비움
 	out.print("즐거운 목요일"); // 버퍼 공간에 out.print 저장
 	out.print("<h2>out 내장 객체</h2>");
 
 	// 기본 8kb (1kb = 1024byte)
 	out.print("출력 버퍼의 크기: " + out.getBufferSize() + "<br>");  // 버퍼의 크기
 	out.print("남은 버퍼의 크기: " + out.getRemaining() + "<br>");   // 남은 버퍼 크기
 	
 	out.flush();  // 버퍼의 내용 출력 -> 버퍼의 크기 변경
 	out.print("남은 버퍼의 크기: " + out.getRemaining() + "<br>"); 
 	
 	out.print(1); // char, boolean 등 다양한 타입 출력할 수 있다
 %>
 
</body>
</html>