<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "../common/header.jsp" %>
	<h3>도서목록</h3>
	총 건수 : ${totalCnt }
<!-- 검색 -->
<%@ include file = "../common/SearchForm.jsp" %>

<table border="1" width="90%" style="border-collapse: collapse">
	<tr style="border-style: none">
		<td colspan="5" class="right" style="border: none">
			<!-- 도서 등록 도서 삭제 -->
			<c:if test="${sessionScope.adminYN eq 'Y' }">
				<button type="button" onclick="location.href='../book/write.do'">도서등록</button>
				<button type="button" onclick="location.href='../book/write.do'">도서삭제</button>
			</c:if>
		</td>
	</tr>
<!-- 목록출력 -->
	<tr>
		<th width="5%"></th>
		<th width="20%">제목</th>
		<th width="10%">저자</th>
		<th width="20%">대여여부/반납일</th>
		<th width="20%">등록일</th>
	</tr>
	<tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="5" class="center">등록된 게시물이 없습니다</td>
				</tr>
			</c:when>
			
		<c:otherwise>
			<c:forEach items="${list }" var="book" varStatus="loop">
				<tr align="center">
					<!-- 삭제용 체크박스 -->
					<td><input type="checkbox" name="delno" value="${book.no }"></td>
					<td><a href="../book/view.do?idx=${book.no}"> ${book.title }</a></td>
					<td>${book.author }</td>
					<td>${book.rentyn }</td>
					<td>${book.postdate }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

<!-- 페이징 -->
	<table border="1" width="90%" style="border-collapse: collapse">
		<tr style="border-style: none">
			<td align="center" style="border: none">
				<%@ include file= "../common/PageNavi.jsp" %>
			</td>
		</tr>
	</table>
<!-- 상세 -->
<!-- 삭제 -->
<!-- 등록 -->	
</body>
</html>