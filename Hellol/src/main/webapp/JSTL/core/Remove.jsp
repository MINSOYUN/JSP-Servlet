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
<!-- 변수 선언 -->
<c:set var="scopeVar" value="Page Value"></c:set> <!-- 스코프를 지정하지 않으면 page 영역 -->
<c:set var="scopeVar" value="Request Value" scope="request"></c:set>
<c:set var="scopeVar" value="Session Value" scope="session"></c:set>
<c:set var="scopeVar" value="Application Value" scope="application"></c:set>

<ul>
	<li>페이지 영역 : ${scopeVar }</li>
	<li>리퀘스트 영역 : ${requestScope.scopeVar }</li>
	<li>세션 영역 : ${sessionScope.scopeVar }</li>
	<li>어플리케이션 영역 : ${applicationScope.scopeVar }</li>
</ul>

<%
//request.getAttribute(name);
//request.setAttribute(name, o);
//request.removeAttribute(name);
%>
<h4>session영역에서 삭제</h4>
<c:remove var="scopeVar" scope="session"/> <!-- session에서 삭제하기 때문에 scope 지정하기 -->
<ul>
	<li>페이지 영역 : ${scopeVar }</li>
	<li>리퀘스트 영역 : ${requestScope.scopeVar }</li>
	<li>세션 영역 : ${sessionScope.scopeVar }</li>
	<li>어플리케이션 영역 : ${applicationScope.scopeVar }</li>
</ul>
<h4>영역을 지정하지 않고 삭제</h4> <!-- 모든 영역의 변수를 삭제 -->
<c:remove var="scopeVar"/>
<ul>
	<li>페이지 영역 : ${scopeVar }</li>
	<li>리퀘스트 영역 : ${requestScope.scopeVar }</li>
	<li>세션 영역 : ${sessionScope.scopeVar }</li>
	<li>어플리케이션 영역 : ${applicationScope.scopeVar }</li>
</ul>
</body>
</html>