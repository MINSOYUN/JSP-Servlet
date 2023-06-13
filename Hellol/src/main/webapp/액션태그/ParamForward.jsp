<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 액션태그는 태그의 형태로 지니고 있어 소스의 이질감이 줄어들고 jsp 코드보다 훨씬 짧은 코드로 동일한 기능을 구현할 수 있다 -->
<h3>자바빈을 활용한 매개변수 전달</h3>
	<% request.setCharacterEncoding("utf-8"); %>
	<jsp:useBean id="person" class="dto.Person" scope="request"></jsp:useBean>
	이름: <jsp:getProperty property="name" name="person"/>
	나이: <jsp:getProperty property="age" name="person"/>

<h3>forward된 페이지에서 매개변수 확인</h3>
	<%=request.getParameter("param1") %><br>  <!-- request.getParameter 사용 -->
	<%=request.getParameter("param2") %><br>
	<%=request.getParameter("param3") %><br>
	
<!-- jsp:include 액션태그를 이용해 다른 페이지를 불러올 때 jsp:param 액션 태그를 이용 시 파라미터를 전달 할 수 있다 -->
<h3>jsp:include 페이지에 파라미터 넘기기</h3>
	<jsp:include page="inc/ParamInclude.jsp">
		<jsp:param value = "서울 강남" name="loc1"/>
		<jsp:param value = "강남역" name="loc2"/>
	</jsp:include>
</body>
</html>