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
	String pValue = "StringValue";
%>
	<jsp:forward page="prec2.jsp?param1=쿼리스트링">
		<jsp:param value="param2" name="param2"/> <!-- value: 값 / name: 이름 -->
		<jsp:param value="<%= pValue %>" name="param3"/>
	</jsp:forward>
</body>
</html>