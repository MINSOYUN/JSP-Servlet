<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DTO.Person" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!--  맵에 있는 값 꺼내오기 -->
	<% 
	// 브라우저가 닫았다가 다시 열어도 값이 유지가 됩니다
	// 서버 종료 후 다시 실행시 제거되는 것을 확인 할 수 있다
	Map<String, Person> maps = (Map<String, Person>)application.getAttribute("maps");
	
	// 맵에 담겨진 데이터의 키 값을 조회 한다
	// key set(): 키의 집합을 set 타입으로 반환
	Set<String> keys = maps.keySet();
	
	// map은 key, value가 쌍으로 저장되는 컬렉션 타입
	// get(key): 키 값을 이용하여 value 값을 반환
	for(String key : keys){
		Person p = maps.get(key);
		out.print(p.getName() + "/" + p.getAge()+ "<br>");
	}
	%>
</body>
</html>