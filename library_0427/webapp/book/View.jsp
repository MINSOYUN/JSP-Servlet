<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
</head>
<body>
<h3>도서 상세보기(View)</h3>

<table border="2" width="90%" height = "200px" style="border-collapse: collapse">
    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup>

    <!-- 게시글 정보 -->
    <tr>
        <td>번호</td> <td>${ book.no }</td>
        <td>대여여부</td> <td>${ book.rentyn }</td>
    </tr>
    <tr>
        <td>제목</td> <td colspan="4">${ book.title }</td>
    </tr>
    <tr>
        <td>저자</td><td >${ book.author }</td>
        <td>출판사</td><td >${ book.publisher }</td>
    </tr>
    <tr>
       <td>조회수</td><td >${ book.visitcount }</td>
       <td>등록일</td><td >${ book.postdate }</td>
    </tr>
</table>

<table border="1" width="90%" height = "150px" >
    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="location.href='../book/pass.book?mode=edit&no=${ param.no }';">
                수정하기
            </button>
            <button type="button" onclick="location.href='../book/pass.book?mode=delete&no=${ param.no }';">
                삭제하기
            </button>
            <button type="button" onclick="location.href='../book/list.book';">
                목록 바로가기
            </button>
       </td>
     </tr>       
     <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="location.href='';">
                대여하기
            </button>
            <button type="button" onclick="location.href='';">
                반납하기
            </button>
         </td>
    </tr>
</table>
</body>
</html>
