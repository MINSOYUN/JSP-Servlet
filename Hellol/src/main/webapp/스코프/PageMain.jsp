<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "DTO.Person" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	pageContext.setAttribute("page","페이지영역(스코프)"); // 이름 , 값
	pageContext.setAttribute("page_int", 10000);
	pageContext.setAttribute("pagePerson", new Person("하니", 20));
	%>
	
	<h3>page 영역의 속성 값 읽기</h3>
	<%
	// getAttribute 반환 타입 -> object
	String page_str = pageContext.getAttribute("page").toString();
	int page_int = (Integer)pageContext.getAttribute("page_int");
	Person page_person = (Person)pageContext.getAttribute("pagePerson");
	%>
	
	<ul>
		<li>String: <%= page_str %></li>
		<li>int: <%= page_int %></li>
		<li>Person: <%= page_person.getName()%>, <%= page_person.getAge()%></li>
	</ul>
	
	<h3>include 된 파일에서 page 영역 읽어오기</h3>
	<p>include 지시어로 감싼 JSP 파일은 포함 관계를 가지므로 같은 페이지 영역이 공유 된다</p>
	<%@ include file = "PageInclude.jsp" %>
	
	<h3>페이지 이동 후 page 영역 읽어오기</h3>
	<!-- 링크를 이용해서 페이지를 다시 요청하게 되면 페이지 영역(+request 영역)이 초기화 된다 -->
	<a href = "PageLocation.jsp">PageLocation.jsp 바로가기</a>
</body>
</html>