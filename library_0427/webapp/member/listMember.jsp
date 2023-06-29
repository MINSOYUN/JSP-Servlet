<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		background-color: #F9F9F9;
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}
	
	table th, table td {
		border: 1px solid #000;
		padding: 10px;
		text-align: center;
	}
	
	table th {
		background-color: #e9e9e9e0;
	}
	
	.button-two {
        margin: 10px;
        padding: 10px 20px;
    }
	
	.empty-row td {
		text-align: center;
		font-style: italic;
		color: #888;
	}
	
	.button-container {
		text-align: right;
		margin-top: 10px;
	}
	
	.button-container > button {
		margin-left: 10px;
		padding: 10px 20px;
		border: none;
		background-color: #fcbe62;
		color: #FFF;
		border-radius: 5px;
	}
	
	.button-container button:hover {
		background-color: #FF9800;
	}
</style>
<script type="text/javascript">

	let message = '${message}';
	if(message != null && "" != message){
		alert(message);
	}
	
	 function deleteMember(){
	 	// 체크박스가 선택된 요소의 value 값을 , 로 연결
	 	delNoList = document.querySelectorAll("[name=delNo]:checked");
	 	
	 	let delNo = "";
	 	delNoList.forEach((e) =>{
	 		delNo += e.value + ',';
	 	});
	 	
	 	delNo = delNo.substr(0, delNo.length-1);
	 	console.log(delNo);
	 	
	 	// 삭제 요청
	 	searchForm.action = "../member/delete.member";
	 	searchForm.delNo.value=delNo;
	 	searchForm.submit();  // 함수 ()
	 }
</script>
</head>
<body>
<%@ include file="../common/header.jsp" %>
	<h3>관리자목록</h3>
	총 회원 수 : ${totalCnt } 명
	<%@ include file = "../common/SearchMember.jsp" %>
	
	
	<div class="button-two">
	    <c:if test="${sessionScope.adminYn eq 'Y'}">
	        <button onclick="location.href='../book/write.book'">도서등록</button>
	        <button onclick="deleteBook()">도서삭제</button>
	    </c:if>
	</div>

	<table>
		<!-- 목록출력 -->
		<tr>
			<th></td>
			<th width="20%">아이디</th>
			<th width="10%">비밀번호</th>
			<th width="10%">이름</th>
			<th width="15%">관리자여부</th>
			<th width="10%">상태</th>
			<th width="20%">등급</th>
		</tr>
		
		<c:if test="${empty list }" var="emptylist">
			<tr class="empty-row">
				<td colspan="6">등록된 관리자가 없습니다</td>
			</tr>
		</c:if>
		
		<c:if test="${not emptylist }">
			<c:forEach items="${list }" var="member" step="1">
				<tr align="center">
					<td><input type="checkbox" name="delNo" value="${book.no }"></td>
					<td><a href="./view.member?id=${member.id}"> ${member.id }</a></td>
					<td>${member.pw }</td>
					<td>${member.name }</td>
					<td>${member.adminyn }</td>
					<td>${member.status }</td>
					<td>${member.grade }</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<tr>
			<td colspan="6" class="button-container">
				<button type="button" onclick="location.href='../loginAdmin2.jsp';">관리자 메뉴 바로가기</button>
			<c:if test="${sessionScope.adminYn eq 'Y'}">
				<button type="button" onclick="location.href='./delete.member';">관리자 삭제</button>
				<button type="button" onclick="location.href='./write.member';"">관리자 등록</button>
			</c:if>
		</td>
	</tr>
</table>
<table>
    <tr>
        <td class="center">
				<c:set var="pageDto" value="${pageDto }"/>  
				<%@ include file= "../common/PageNaviMember.jsp" %>
			</td>
		</tr>
</table>
</body>
</html>