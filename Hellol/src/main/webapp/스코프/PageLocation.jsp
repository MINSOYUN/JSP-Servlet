<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>페이지 이동 후 page 영역의 속성값 읽기</h3>
	<%
	Object page_str = pageContext.getAttribute("page");
	Object page_int = pageContext.getAttribute("page_int");
	Object page_person = pageContext.getAttribute("pagePerson");
	%>
	
	<ul>
		<li>String: <%= (page_str == null)? "값 없음" : page_str %></li>
		<li>int: <%= (page_int == null) ? "값 없음" : page_int %></li>
		<li>person: <%= (page_person == null)? "값 없음" : page_person %></li>
		
	</ul>
</body>
</html>