<%@page import="utils.CookieManager"%>
<%@page import="el.MyELClass"%>
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
	MyELClass myClass = new MyELClass();
	pageContext.setAttribute("myClass", myClass);	
	pageContext.setAttribute("response", response); // 왜 작성해야하는지 공부!
%>

<h3>영역에 저장 후 메서드 호출하기</h3>
	001129-3000000 => ${myClass.getGender("001129-3000000")} <br>
	001120-4000000 => ${myClass.getGender("001120-4000000")} <br>

<h3>정적 메서드 호출하기</h3>
	${MyELClass.showGugudan(7)}
	
<h3>정적 메서드 호출하기 - 쿠키 생성하기</h3>
	${CookieManager.makeCookie(response, "ELCookie", "EL", 10) } <br>
	${cookie.ELCookie.value } <!-- nullPointerException -> why? response 가 null 위에 response 설정해주기-->

<h3>메서드 호출하기</h3>
</body>
</html>