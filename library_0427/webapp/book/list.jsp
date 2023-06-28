<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	let message = '${message}';
	if(message != null && "" != message){
		alert(message);
	}
	
	 function deleteBook(){
	 	// 체크박스가 선택된 요소의 value 값을 , 로 연결
	 	delNoList = document.querySelectorAll("[name=delno]:checked");
	 	
	 	let delNo = "";
	 	delNoList.forEach((e) =>{
	 		delNo += e.value + ',';
	 	});
	 	
	 	delNo = delNo.substr(0, delNo.length-1);
	 	console.log(delNo);
	 	
	 	// 삭제 요청
	 	searchForm.action = "../book/delete.book";
	 	searchForm.delNo.value=delNo;
	 	searchForm.submit();  // 함수 ()
	 }
</script>

</head>
<body>
<%@ include file = "../common/header.jsp" %>
<p align="right">😄 ${sessionScope.userId } 님 환영합니다 😄</p>
	<h3>도서목록</h3>
	총 건수 : ${map.totalCnt } 건
<!-- 검색 -->
<%@ include file = "../common/SearchForm.jsp" %>

<table border="1" width="100%" style="border-collapse: collapse">
	<tr style="border-style: none">
		<td colspan="7" class="right">
			<!-- 도서 등록 도서 삭제 -->
			
			<c:if test="${sessionScope.adminYn eq 'Y'}">
				<button onclick="location.href='../book/write.book'">도서등록</button>
				<button onclick="deleteBook()">도서삭제</button>
			</c:if>
		</td>
	</tr>
<!-- 목록출력 -->
	<tr>
		<th width="5%"></th>
		<th width="20%">도서명</th>
		<th width="10%">저자</th>
		<th width="10%">출판사</th>
		<th width="15%">대여여부/반납일</th>
		<th width="10%">조회수</th>
		<th width="20%">등록일</th>
	</tr>
		<c:choose>
			<c:when test="${empty map.list }">
				<tr>
					<td colspan="7" class="center">등록된 게시물이 없습니다</td>
				</tr>
			</c:when>
			
		<c:otherwise>
			<c:forEach items="${map.list }" var="book" step="1">
				<tr align="center">
					<!-- 삭제용 체크박스 -->
					<td><input type="checkbox" name="delno" value="${book.no }"></td>
					<td><a href="../book/view.book?no=${book.no}"> ${book.title }</a></td>
					<td>${book.author }</td>
					<td>${book.publisher }</td>
					<td>${book.rentyn }</td>
					<td>${book.visitcount }</td>
					<td>${book.postdate }</td>
				</tr>
			</c:forEach>
		</c:otherwise>
	</c:choose>
</table>


<!-- 페이징 -->
<table border="1" width="100%" style="border-collapse: collapse">
		<tr style="border-style: none">
			<td align="center" style="border: none">
				<c:set var="pageDto" value="${map.pageDto }"/>
				<%@ include file= "../common/PageNavi.jsp" %>
			</td>
		</tr>
</table>


</body>
</html>