<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "java.util.Collection" %>
    <%@ page import = "java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	/* response 객체는 응답 헤더에 정보를 추가하는 기능을 제공
		add...(): 응답 헤더 추가
		set...(): 응답 헤더 수정
	*/
	String add_date = request.getParameter("add_date"); 
	String add_int = request.getParameter("add_int");	
	String add_str = request.getParameter("add_str");
	
	response.addHeader("str", add_str);  // 응답 헤더에 새로운 헤더 추가
	//getParameter()는 String 타입을 반환하므로 숫자나 날짜 타입인 경우 형변환 필요!
	response.addIntHeader("int", Integer.parseInt(add_int));
	
	SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm");  // 날짜와 시간 형식 지정
	// getTime() -> 롱타입으로 반환 / parse 문자열을 형식에 맞게 파싱
	response.addDateHeader("date",s.parse(add_date).getTime());    // (String name, long) 타입
	
	// 갑자기 왜 반환타입? 
	// 반환타입 Collection -> import / String의 집합 
	Collection<String> headerNames = response.getHeaderNames();  // 응답에 포함된 모든!! 헤더의 이름을 가져온다
	for(String hName : headerNames){
		String hValue = response.getHeader(hName);  // hName에 해당하는 헤더의 값을 반환한다 -> 단일값
%>
	<li><%= hName %> : <%= hValue %></li>
	<% } %>
</body>
</html>