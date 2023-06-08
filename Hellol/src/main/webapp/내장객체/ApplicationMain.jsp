<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체-application</title>
</head>
<body>
	<%
	// xml에 설정한 파라미터 읽어오기
	String init = application.getInitParameter("INIT_PARAM");
	// 서버의 물리적 경로 읽어오기
	String path = application.getRealPath("/내장객체");
	%>
	<h3>application</h3>
	초기화 매개변수 : <%= init %> <br>
	내장객체의 물리적 주소 : <%= path %>
	
	<h3>선언부에서 application 내장객체 사용하기</h3>
	<%!
	// 메서드 선언, 필드 선언
	// application 타입 -> ServletContext
	public String useImplicitObject(){
		return this.getServletContext().getRealPath("/내장객체");
	}
	public String useImplicitObject(ServletContext app){
		return app.getRealPath("/내장객체");
	}
	%>
	
	<ul>
		<li>this 사용: <%= useImplicitObject() %></li>
		<li>내장객체를 인수로 전달: <%= useImplicitObject(application)%></li>
	</ul>
</body>
</html>