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
    }
</style>
<script type="text/javascript">

	let message = '${message}';
	if(message != null && "" != message){
		alert(message);
	}
	
	 function deleteBook(){
	 	// 체크박스가 선택된 요소의 value 값을 , 로 연결
	 	delNoList = document.querySelectorAll("[name=check]:checked");
	 	
	 	let delNo = "";
	 	delNoList.forEach((e) =>{
	 		delNo += e.value + ',';
	 	});
	 	
	 	delNo = delNo.substr(0, delNo.length-1);
	 	console.log(delNo);
	 	
	 	// 삭제 요청
	 	searchForm.action = "../user/delete.user";
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
<h3>구매하기</h3>
<p>총 건수: ${map.totalCnt} 건</p>

<%@ include file="../common/SearchForm.jsp" %>

<div class="button-container">
        <button onclick="deleteBook()">선택한 도서삭제</button>
</div>
<form name="purchaseFrm" method="post" action="../user/purchase.user">
<table>
    <tr>
        <th>도서번호</th>
        <th>도서사진</th>
        <th>도서명</th>
        <th>저자</th>
        <th>출판사</th>
        <th>장바구니에 담긴 날</th>
    </tr>
    <c:choose>
        <c:when test="${empty map.list}">
            <tr>
                <td colspan="7" class="center">구매 목록에 담긴 도서가 없습니다</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${map.list}" var="purchase" step="1">
                <tr>
                	<td><input type="checkbox" name="check" value="${basket.no }"></td>
                    <td><a href="../user/view.user?no=${basket.no}">${basket.title}</a></td>
                    <td>${basket.sfile}</td>
                    <td>${basket.title}</td>
                    <td>${basket.author}</td>
                    <td>${basket.publisher}</td>
                    <td>${basket.regidate}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
    <tr>
        <td colspan="7" align="center">
        	<button type="button" onclick="location.href='./Purchase.jsp';">
            <button type="button" onclick="location.href='../book/list.book';">
                목록 바로가기
            </button>
           	<c:if test=""></c:if>
            
        </td>
	    </tr>
</table>
</form>
</body>
</html>