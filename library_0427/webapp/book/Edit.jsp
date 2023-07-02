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
    <style>
        body {
            background-color: #F9F9F9;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .required-label {
	        font-size: 12px;
	        color: red;
	        padding-left: 10px;
   		 }

        table td {
            padding: 10px;
        }

        input[type="text"], textarea{
        	width: 90%;
        	padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="file"] {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"],
        input[type="reset"],
        button {
            padding: 10px 30px;
            border: none;
            border-radius: 5px;
            color: #FFF;
        }

        button {
            background-color: #fcbe62;
        }

        button:hover {
            background-color: #FF9800;
        }
    </style>
</head>
<body>
<h2>도서 정보 수정하기</h2>
<form name="writeFrm" method="post" action="../book/edit.book" enctype="multipart/form-data">
<input type="hidden" name="no" value="${ book.no }"/>
<table border="1" width="100%" height="150px">
    <tr>
        <td>도서명<span class="required-label">*</span></td>
        <td>
            <input type="text" name="title" value="${ book.title }" />
        </td>
         <td>저자<span class="required-label">*</span></td>
        <td>
            <input type="text" name="author" value="${ book.author }" />
        </td>
    </tr>
    <tr>
        <td>출판사<span class="required-label">*</span></td>
        <td>
            <input type="text" name="publisher" value="${ book.publisher }" />
        </td>
        <td>대여여부<span class="required-label">* </span></td>
        <td>
            <input type="text" name="rentyn" value="${ book.rentyn }" />
        </td>
    </tr>
    <tr>
        <td>도서사진<span class="required-label">*</span></td>
        <td>
        	 <img alt="${ book.title }이미지" src="../images/bookImg/${book.sfile }"  style="width: 200px;">
        	<input type="file" name="bookImg" style="width:60%;" />
        </td>
	    <td>상세설명<span class="required-label">*</span></td>
	    <td colspan="4">
		      <textarea name="info" id="" cols="50" rows="20" >${ book.info }</textarea>
		 </td>
   	</tr>
    <tr>
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