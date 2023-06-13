<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>포워드 결과 확인</h3>
	<ul>
		<li>
		page 영역: <br>
		<%= pageContext.getAttribute("pAttr") %> <br>
		<%= request.getParameter("pAttr") %> 	<!--  URL 매개변수(pAttr)의 값을 가져오는 메서드 -->
		</li>
		<li>request 영역: <%= request.getAttribute("rAttr") %></li>
	</ul>
	
</body>
</html>