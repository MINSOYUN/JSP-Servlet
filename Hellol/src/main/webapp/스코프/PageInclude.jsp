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
	
	<ul>
		<li>String: <%= pageContext.getAttribute("page") %></li>
		<li>int: <%= pageContext.getAttribute("page_int") %></li>
		<li>Person: <%= pageContext.getAttribute("pagePerson") %></li>
	</ul>
</body>
</html>