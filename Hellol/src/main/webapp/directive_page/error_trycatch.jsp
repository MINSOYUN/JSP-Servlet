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
	try{
	// request: 사용자의 요청을 담고 있는 객체 -> 파라미터로 넘어온 age를 읽어온다
		int age = Integer.parseInt(request.getParameter("age")); 
		out.print("당신의 나이는 "+age+"입니다");
	} catch(Exception e) {
		out.print("예외발생: "+e.getMessage());
	%>
	
	<h3>오류가 발생 하였습니다. 관리자에게 문의 해주세요 </h3>
	<%= e.getMessage() %>
	
	<%
	}
	 %>
</body>
</html>