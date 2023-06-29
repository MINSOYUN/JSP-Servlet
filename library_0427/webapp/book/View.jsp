<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style>
    body {
        margin: 0;
        padding: 20px;
    }

    h3 {
        margin-top: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th,
    td {
        padding: 10px;
        border: 1px solid #ccc;
    }

    img {
        width: 200px;
        height: auto;
    }
    
    .rental{
    	border: 1px solid #ccc;
    	border-radius: 5px;
		color: #333;
		background-color: #ffffff00;
		padding: 10px 10px;
    }

    button {
        padding: 10px 30px;
        font-size: 14px;
        background-color: #fcbe62;
        color: #fff;
        border: none;
        border-radius: 5px;
    }

    button:hover {
        background-color: #f0f0f0;
    }

</style>
<script type="text/javascript">
    function setAction(action) {
        viewForm.action = action;
    }
</script>
</head>
<body>
<%@include file="/common/header.jsp" %>
<h3>도서 상세보기</h3>
도서번호 : <input type="text" name="no" value="${book.no }">
대여번호 : <input type="text" name="rentno" value="${book.rentno }">

<form name="viewForm" method="post">
    <table>
        <colgroup>
            <col width="30%" />
            <col width="15%" />
            <col width="20%" />
            <col width="15%" />
            <col width="20%" />
        </colgroup>

        <!-- 게시글 정보 -->
        <tr>
            <td rowspan="3">
                <img alt="${ book.title }이미지" src="../images/bookImg/${book.sfile }">
            </td>
            <td>도서명</td>
            <td>${ book.title }</td>
            <td>작가</td>
            <td>${ book.author }</td>
        </tr>
        <tr>
            <td>대여</td>
            <c:choose>
                <c:when test="${empty book.rentno}">
                    <td colspan="3"><button  class='rental' onclick="setAction('./rent.book?no=${book.no}')">대여하기</button></td>
                </c:when>
                <c:when test="${book.id eq sessionScope.userId }">
                    <td><button class='rental' onclick="setAction('./return.book?no=${book.no}')">반납하기</button></td>
                    <td>대여기간</td>
                    <td>${ book.startDate } ~ ${ book.endDate }</td>
                </c:when>
                <c:otherwise>
                    <td>대여중</td>
                    <td>대여기간</td>
                    <td>${ book.startDate } ~ ${ book.endDate }</td>
                </c:otherwise>
            </c:choose>
        </tr>
        <tr>
	         <td>상세설명</td>
	     	 <td colspan="4">
		            <textarea name="info" id="" cols="50" rows="10" readonly>${ book.info }</textarea>
		     </td>
   		</tr>
	<!-- 하단 메뉴(버튼) -->
	    <tr>
	        <td colspan="5" align="center">
	            <button type="button" onclick="location.href='./edit.book?no=${book.no}';">
	                수정하기
	            </button>
	            <button type="button" onclick="location.href='./delete.book?delNo=${ book.no }';">
	            	삭제하기
	            </button>
	            <button type="button" onclick="location.href='./list.book';">
	                목록 바로가기
	            </button>
	           	<c:if test=""></c:if>
	            
	        </td>
	    </tr>
</table>
</form>
</body>