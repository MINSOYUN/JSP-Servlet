<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("replaceChar", "\r\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
    function validateForm(form) {
        if (form.name.value == "") {
            alert("작성자를 입력하세요.");
            form.name.focus();
            return false;
        }
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
    }
</script>

<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        font-size: 14px;
    }
    h2 {
        text-align: center;
    }
    form {
        margin: 0 auto;
        width: 80%;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }
    th, td {
        padding: 10px;
        border: 1px solid #ccc;
    }
    input[type="text"] {
        width: 100%;
        height: 80%;
        padding: 5px;
        box-sizing: border-box;
    }
    button {
        padding: 10px 20px;
        background-color: #f9f9f9;
        border: 1px solid #ccc;
        cursor: pointer;
    }
    button[type="submit"] {
        background-color: #4CAF50;
        color: #fff;
    }
    button[type="reset"] {
        background-color: #f44336;
        color: #fff;
    }
    button[type="button"] {
        background-color: #2196F3;
        color: #fff;
    }
    button[type="submit"], button[type="reset"], button[type="button"] {
        margin-right: 10px;
    }
    button:hover {
        background-color: #e0e0e0;
    }
    td[colspan="4"] {
        text-align: center;
    }
</style>
</head>

<body>
<h2>도서 정보 수정하기</h3>
<form name="writeFrm" method="post" action="../book/edit.book" onsubmit="return validateForm(this);">
<input type="hidden" name="no" value="${ book.no }"/>
<table border="1" width="100%" height="150px">
    <tr>
        <td>도서명</td>
        <td>
            <input type="text" name="title" value="${ book.title }" />
        </td>
         <td>저자</td>
        <td>
            <input type="text" name="author" value="${ book.author }" />
        </td>
    </tr>
    <tr>
        <td>출판사</td>
        <td>
            <input type="text" name="publisher" value="${ book.publisher }" />
        </td>
        <td>대여여부</td>
        <td>
            <input type="text" name="rentyn" value="${ book.rentyn }" />
        </td>
    </tr>
    <tr>
        <td colspan="4" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='../book/list.book';">
                   목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</body>
</html>
               
