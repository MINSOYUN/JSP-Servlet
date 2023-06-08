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
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pwd");
	out.print("id" + id +"<br>");
	out.print("pw" + pw +"<br>");
	
	if("abc".equals(id) && "123".equals(pw)){
		out.print("로그인성공");
	
	} else{
		out.print("로그인실패");
		response.sendRedirect("main.jsp?err=1");
	}
	%>
</body>
</html>