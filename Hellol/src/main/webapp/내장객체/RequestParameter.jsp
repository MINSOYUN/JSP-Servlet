<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 한글 깨짐 처리 -->
	<%
	 request.setCharacterEncoding("UTF-8");
	 String id = request.getParameter("id"); // () 메인속성 name이 id인 value값 가져온다
	 String sex = request.getParameter("sex");
	 String[] favo = request.getParameterValues("favo");  	 // 체크박스는 배열형태로 읽어온다
 	// 줄바꿈이 있는 경우 \r\n -> <br>
	 String intro = request.getParameter("intro");
	 String favostr = "";
	 out.print(Arrays.toString(favo));
	 %>
	 <ul>
	 	<li>아이디: <%=id %></li>
	 	<li>성별: <%=sex %></li>
	 	<li>관심사항: <%=Arrays.toString(favo) %></li>
	 	<li>자기소개: <%=intro.replace("\r\n","<br>") %> </li>
	 	
	 </ul>
</body>
</html>