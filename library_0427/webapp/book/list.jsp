<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    body {
    }

    h3 {
        text-align: center;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 8px;
    }

    th {
        background-color: #f2f2f2;
    }

    .center {
        text-align: center;
    }

    .info {
        text-align: right;
        padding: 10px;
        font-weight: bold;
    }

    .info a {
        color: #333;
        text-decoration: none;
    }

    .button-container {
        margin: 10px;
        padding: 10px 20px;
    }
</style>
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
<%@ include file="../common/header.jsp" %>
<div class="info">
    😄 ${sessionScope.userId} 님 환영합니다 😄
</div>
<h3>도서목록</h3>
<p>총 건수: ${map.totalCnt} 건</p>

<%@ include file="../common/SearchForm.jsp" %>

<div class="button-container">
    <c:if test="${sessionScope.adminYn eq 'Y'}">
        <button onclick="location.href='../book/write.book'">도서등록</button>
        <button onclick="deleteBook()">도서삭제</button>
    </c:if>
</div>

<table>
    <tr>
        <th>도서명</th>
        <th>저자</th>
        <th>출판사</th>
        <th>대여여부/반납일</th>
        <th>조회수</th>
        <th>등록일</th>
    </tr>
    <c:choose>
        <c:when test="${empty map.list}">
            <tr>
                <td colspan="6" class="center">등록된 게시물이 없습니다</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${map.list}" var="book" step="1">
                <tr>
                    <td><a href="../book/view.book?no=${book.no}">${book.title}</a></td>
                    <td>${book.author}</td>
                    <td>${book.publisher}</td>
                    <td>${book.rentyn}</td>
                    <td>${book.visitcount}</td>
                    <td>${book.postdate}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</table>

<table>
    <tr>
        <td class="center">
				<c:set var="pageDto" value="${map.pageDto }"/>
				<%@ include file= "../common/PageNavi.jsp" %>
			</td>
		</tr>
</table>
</body>
</html>