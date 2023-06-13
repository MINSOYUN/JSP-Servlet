<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>forward된 페이지에서 매개변수 확인</h3>
	<%=request.getParameter("param1") %><br>  <!-- request.getParameter 사용 -->
	<%=request.getParameter("param2") %><br>
	<%=request.getParameter("param3") %><br>
</body>
</html>