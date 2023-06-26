<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<header>
	userId : ${sessionScope.userId }
	adminYN : ${sessionScope.adminYn }
	
	<!-- 어드민 -->
	<c:if test="${sessionScope.adminYn } eq 'Y'" var="res">
		<div>로고</div>
		<div>
			<a href="">도서관리</a>
			<a href="">사용자관리</a>
		</div>
			<div>로그아웃</div>
	</c:if>
	
	<!-- 사용자 -->
	<c:if test="${not res }">
		<div>로고</div>
		<div>
			<a href="">도서관리시스템</a>
		</div>
			<a href="">마이페이지</a>
			
	<!-- 로그인 x -->
	<c:if test="${empty sessionScope.userId }" var="res1">
		<div>로그인</div>
	</c:if>
	
	
	</c:if>
	
	<!-- 사용자 -->
	<c:if test="${sessionScope.userId }">
		<a href = "${pageContext.request.contextPath }/book/loginMember.do">사용자 모드</a> <br>
	</c:if>
	
	<!-- 로그인 전 사용자 -->
	
</header>

</body>
</html>