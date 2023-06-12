<%@page import="java.util.ArrayList"%>
<%@page import="dto.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>session 영역의 속성 읽기</h3>
	<%
	if(session.getAttribute("person") != null){   // null이 아니면 형변환 해줘
		Person p = (Person) session.getAttribute("person");
		out.print(p.getName() + ",");
		out.print(p.getAge());
	} else{
		 // 브라우저를 닫았다 새로 열면 쿠키에 저장된 세션 ID 값이 변경되므로 기존 세션은 유지되지 않고새로운 세션이 연결된다
		out.print("session에 person 객체가 없습니다");
	}
	
	if(session.getAttribute("list") != null){
		// list의 객체를 가져온다 getAttribute
		ArrayList<String> list = (ArrayList<String>)session.getAttribute("list");
		for(String str : list){
			out.print(str+"<br>");
		}
	}
	%>
</body>
</html>