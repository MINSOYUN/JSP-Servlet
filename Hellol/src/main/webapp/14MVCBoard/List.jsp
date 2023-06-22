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
<h3>MVC 모델 2 게시판</h3>
	
	<!-- 검색폼 --> 
<form method="get" name="searchForm">  
<table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord""/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
</table>
</form>
	
	
<table border="1" style="border-collapse:collapse">
	<tr>
		<th>번호</th>
		<th>이름</th>
		<th>제목</th>
		<th>내용</th>
		<th>등록일</th>
		<th>원본 파일명</th>
		<th>저장된 파일명</th>
		<th>다운로드횟수</th>
		<th>비밀번호</th>
		<th>조회수</th>
	</tr>
	<c:choose>
	<c:when test="${empty list }">
		<tr>
			<td colspan = "10">등록된 게시물이 없습니다</td>
		</tr>
	</c:when>
	
	<c:otherwise>
	<c:forEach items="${list }" var="row" varStatus="loop"> 
	<tr align ="center">
		<td>${row.idx }</td>
		<td>${row.name }</td>
		<td>${row.title }</td>
		<td>${row.content }</td>
		<td>${row.postdate }</td>
		<td>${row.ofile }</td>
		<td>${row.sfile }</td>
		<td>${row.downcount }</td>
		<td>${row.pass }</td>
		<td>${row.visitcount }</td>
	</tr>
	</c:forEach>
	<a href="${pageContext.request.contextPath }/mvcboard/list.do">게시판 목록 바로가기</a>
	</c:otherwise>
	</c:choose>
</table>

</body>
</html>