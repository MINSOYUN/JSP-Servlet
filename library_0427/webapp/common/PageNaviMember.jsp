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
<script>
	function go(page){
		document.searchForm.action="./listMember.member";
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
		
	}
</script>

<!-- 저장해둔 영역에서 찾는다 -> request -->
<c:set var="pageDto" value="${pageDto }"></c:set>

<c:if test="${pageDto.prev}">
	<input type='button' value='<<' onclick = 'go(1)'>
	<input type='button' value='<' onclick='go(${pageDto.startNo-1 })'>
</c:if>

<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" step="1" var="i">
	<input type='button' value='${i}' onclick='go(${i})'>
</c:forEach>

<c:if test="${pageDto.next}">
	<input type='button' value='>' onclick = 'go(${pageDto.endNo+1})'>
	<input type='button' value='>>' onclick = 'go(${pageDto.realEnd})'>
</c:if>

</body>
</html>