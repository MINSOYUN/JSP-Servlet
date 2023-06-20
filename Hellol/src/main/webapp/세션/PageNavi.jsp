<%@page import="dto.PageDto"%>
<%@page import="dao.Criteria"%>
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
		// form 의 name 과 동일하게 설정
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
		
	}
</script>
<c:set var="pageDto" value="<%=pageDto%>"></c:set>

<c:if test="${pageDto.prev}">
	<a href='List.jsp?pageNo=1'>맨앞</a>
	<a href='List.jsp?pageNo=${pageDto.startNo-1 }'>이전</a>
</c:if>

<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" step="1">
	<a href='List.jsp?pageNo=${pageDto.pageNo }'>${pageDto.pageNo }</a>
</c:forEach>

<c:if test="${pageDto.next}">
	<a href='List.jsp?pageNo=${pageDto.endNo+1 }'>다음</a>
	<a href='List.jsp?pageNo=${pageDto.realEnd }'>끝</a>
</c:if>

<%
	
	// 이전 페이지 블럭 <
	// booelan 타입이라 isPrev
	// pageDto() 통해 1보다 큰 경우에만 true -> '<' 버튼 보인다
	if(pageDto.isPrev()){
		// 제일 앞으로
		out.print("<input type='button' value='<<' onclick = 'go(1)''>");
		// 현재 있는 페이지블럭 앞페이지로 이동하는 것 -> 전페이지블럭으로 이동
		out.print("<input type='button' value='<' onclick = 'go("+(pageDto.getStartNo()-1)+")'>");
	} 
	
	// 1~6
	for(int i= pageDto.getStartNo() ; i<=pageDto.getEndNo(); i++){
		out.print("<input type='button' value='" + i + "' onclick='go("+i+")'>");
	}
	
	// 다음 버튼
	// 페이지블럭의 끝번호와 진짜페이지 번호가 같다면(==) 다음 페이지가 없으므로 false
	if(pageDto.isNext()){
		out.print("<input type='button' value='>' onclick = 'go("+(pageDto.getEndNo()+1)+")'>");
		// 제일 끝으로
		out.print("<input type='button' value='>>' onclick = 'go("+(pageDto.getRealEnd())+")''>");
	}
%>
</body>
</html>