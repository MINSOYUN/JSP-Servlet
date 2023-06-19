<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
	// 리스트 생성(object로 지정 -> 어떤 타입이든지 저장 가능)
	List<Object> aList = new ArrayList<Object>();
	aList.add("청해진");
	aList.add(new Member("test","", "하니", "2023-06-19"));
	
	// 페이지 영역에 리스트 객체 저장
	pageContext.setAttribute("aList", aList);
%>

<h3>List 컬렉션</h3>
<ul>
	<li>0번째 요소</li>
		<p>${aList[0] }</p> <!-- 영역을 지정하지 않았지만 페이지 영역에 저장된 aList의 값이 출력된다 -->
	<li>1번째 요소</li>
		<p>${aList[1] }</p> <!-- 객체의 주소값 출력 -->
		<p>id: ${aList[1].id }</p>
		<p>name: ${aList[1].name }</p>
	<li>2번째 요소</li>
		<p>${aList[2] }</p>  <!-- 없지만 출력 -> 예외 발생 x -->
</ul>


<h3>Map 컬렉션</h3>
<%
	// 키, 값 둘다 String
	Map<String, String> map = new HashMap<String, String>();
	// key, valkue 값 세팅
	map.put("한글", "훈민정음");
	map.put("Eng", "English");
	
	pageContext.setAttribute("map", map);
%>

<ul>
	<li>한글 : ${map['한글']}</li>
	<!-- el 코드 주석 처리 방법: 앞에 역슬래시 \를 붙여 준다 -->
		<p>\${map.한글 }</p> <!-- 에러나지 않고 그대로 출력된다 -->
	<li>영문: ${map.Eng }</li>
		<p><%=map.get("Eng") %></p>
</ul>
</body>
</html>