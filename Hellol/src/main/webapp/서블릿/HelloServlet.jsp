<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	표현식 : <%=request.getAttribute("message") %> <br>
	EL : ${requestScope.message } <br>
	<!-- ./ : 현재 경로 -->
	<!-- 서블릿/HelloServlet.do 가 호출된다 -> web.xml에 작성된 경로-->
	<a href = "./HelloServlet.do">HelloServlet.do 바로가기</a> <br>
	<a href = "${pageContext.request.contextPath }/서블릿/AnnotationMapping.do">AnnotationMapping.do바로가기</a> <br>
</body>
</html>