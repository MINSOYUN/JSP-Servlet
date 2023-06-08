<%@page import="DTO.Person"%>
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
	request.setAttribute("reequest_str", "request 영역에 문자열 저장");
	request.setAttribute("reequest_person", new Person("미미", 25));
	%>
	
	<h3>request 영역의 속성값 읽어오기</h3>
	<%
	String str = (String)request.getAttribute("reequest_str");
	Person person = (Person)request.getAttribute("reequest_person");
	String request_int = (String)request.getAttribute("request_int"); // 존재하지 않는 값 
	%>
	<ul>
		<li> <%= str %></li>
		<li> <%= person.getName() %>, <%=person.getAge() %></li>
		<li> <%= request_int %></li>   <!-- null 출력 -->
	</ul>
	
	<h3>request 영역의 속성값 삭제하기</h3>
	<% 
	request.removeAttribute("reequest_str");
	request.removeAttribute("request_int"); // 존재하지 않는 값 삭제
	%>  
	
	request_str 삭제 : <%= request.getAttribute("request_str")%>
	request_int 삭제: <%= request.getAttribute("request_int") %>
	
	<h3>forward 된 페이지에서 request 영역 속성 값 읽기</h3>
	<%
	request.getRequestDispatcher("RequestForward.jsp?name=하니&age=18").forward(request, response);
	%>
</body>
</html>