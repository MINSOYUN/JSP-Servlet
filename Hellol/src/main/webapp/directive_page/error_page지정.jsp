<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    errorPage ="errorPage.jsp"
    %>
     <!-- 에러페이지 지정 -> 오류가 발생 시 보여 줄 페이지를 지정 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		int age = Integer.parseInt(request.getParameter("age")); 
		out.print("당신의 나이는 "+age+"입니다");
	%>

</body>
</html>