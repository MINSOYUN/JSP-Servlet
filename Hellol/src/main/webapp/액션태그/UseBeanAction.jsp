<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>액션태그로 폼의 값을 한번에 받기</h3>
	// post 처리하여 한글 깨짐 현상이 발생할 수 있다
	<!-- 와일드 카드(*)를 사용하면 모든 폼의 값을 한번에 자바빈즈에 입력할 수 있다 
		setName, setAge 등으로 넘어간다 -->
	
	<jsp:useBean id="person" class="dto.Person"></jsp:useBean>
	
	<%
	request.setCharacterEncoding("utf-8");
	%>
	
	<jsp:setProperty property="*" name="person"/>
	<ul>
		<li>이름: <jsp:getProperty property="name" name="person"/> </li>
		<li>나이: <jsp:getProperty property="age" name="person"/> </li>
	</ul>
</body>
</html>