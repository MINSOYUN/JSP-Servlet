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
	
	 function extensionBook(){
	 	extensionList = document.querySelectorAll("[name=extension]:checked");
	 	
	 	let extension = "";
	 	extensionList.forEach((e) =>{
	 		extension += e.value + ',';
	 	});
	 	
	 	extension = extension.substr(0, extension.length-1);
	 	console.log(extension);
	 	
	 	searchForm.action = "../book/extension.book";
	 	searchForm.delNo.value=extension;
	 	searchForm.submit();  // 함수 ()
	 }
</script>

</head>
<body>
<%@ include file="../common/header.jsp" %>
<div class="info">
    😄 관리자 : ${sessionScope.userId} 님 😄
</div>
<h3>대여 이력이 존재하는 도서</h3>

<%@ include file="../common/SearchForm.jsp" %>

<div class="button-container">
    <c:if test="${sessionScope.adminYn eq 'Y'}">
        <button onclick="extensionBook()">반납 기한 연장하기</button>
    </c:if>
</div>

<table>
    <tr>
    	<th></td>
        <th>도서번호</th>
        <th>도서명</th>
        <th>저자</th>
        <th>조회수</th>
    </tr>
    <c:choose>
        <c:when test="${empty map.list}">
            <tr>
                <td colspan="5" class="center">대여 이력이 있는 도서가 존재하지 않습니다</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach items="${map.list}" var="book" step="1">
                <tr>
                	<td><input type="checkbox" name="extension" value="${book.no }"></td>
                    <td><a href="../book/view.book?no=${book.no}">${book.no}</a></td>
                    <td>${book.title}</td>
                    <td>${book.author}</td>
                    <td>${book.visitcount}</td>
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