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
	<a href="${pageContext.request.contextPath }/mvcboard/list.do">게시판
		목록 바로가기</a>
	<br> 총 게시물수 : ${ totalCnt } 개
	
	<!-- 검색폼 -->
	<form method="get" name="searchForm">
		<table border="1" width="90%">
		
		<input type="hidden" name="pageNo" value="${param.pageNo }">
			<tr>
				<td align="center">${param.searchField eq "name" } <select
					name="searchField">
						<option value="title">제목</option>
						<!-- selected 하나만 작성해도 선택되므로 삼항 연산자 통해서 받아온 param의 값이 value와 같다면 selected -->
						<option value="name"
							${param.searchField eq "name" ? "selected" : ""}>작성자</option>
				</select> <input type="text" name="searchWord" value="${param.searchWord }" />
					<input type="submit" value="검색하기" />
				</td>
			</tr>
		</table>
	</form>


	<table border="1" style="border-collapse: collapse" width="90%">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>작성일</th>
			<th>첨부</th>
		</tr>
		<c:choose>
			<c:when test="${empty list }">
				<tr>
					<td colspan="6">등록된 게시물이 없습니다</td>
				</tr>
			</c:when>

			<c:otherwise>
				<c:forEach items="${list }" var="row" varStatus="loop">
					<tr align="center">
						<td>${row.idx }</td>
						<td><a href="../mvcboard/view.do?idx=${row.idx}"> ${row.title }</a></td>
						<td>${row.name }</td>
						<td>${row.visitcount }</td>
						<td>${row.postdate }</td>
						<td>첨부파일</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>


	<!-- 글쓰기 버튼 추가
	글쓰기 버튼 클릭 시 글쓰기 페이지로 이동 -> 글쓰기 버튼 클릭 시 페이지로 이동-->
	<table border="1" width="90%" style="border-collapse: collapse">
		<tr style="border-style: none">
			<td align="center">
				<%@  include file="../세션/PageNavi.jsp" %>
			</td>
			<td align="right"><button type="button" onclick="location.href='/mvcboard/write.do'">글쓰기</button></td>
		</tr>
	</table>


</body>
</html>