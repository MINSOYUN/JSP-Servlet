<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dto.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- application 영역
	웹 서버가 실행 시 생성되는 영역으로 클라이언트가 요청하는 모든 페이지가 application 영역을 공유
	웹 서버를 종료할 때 소멸
	 -->
	 <h3>application 영역의 공유</h3>
	 <% 
	 Map<String, Person> maps = new HashMap<>(); 
	 maps.put("action1", new Person("GD", 25));
	 maps.put("action2", new Person("대성", 26));
	 
	 application.setAttribute("maps", maps);
	 %>
	 application 영역에 속성이 저장되었습니다
</body>
</html>