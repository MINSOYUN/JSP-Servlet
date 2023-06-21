<%@page import="dao.Criteria"%>
<%@page import="dto.PageDto"%>
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
<%
	int pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));

	Criteria criteria = new Criteria(pageNo);
	
	int total = 300;
	PageDto pageDto = new PageDto(total, criteria);
	
	if(pageDto.isPrev()){
		
	}
	
%>
<c:if test="${pageDto.prev}" var="prev">
	<a href='pageDto.jsp?pageNo=1'>맨앞</a>
	<a href='pageDto.jsp?pageNo=${pageDto.startNo-1 }'>이전</a>
</c:if>

<c:forEach begin="${pageDto.startNo}"></c:forEach>
</body>
</html>