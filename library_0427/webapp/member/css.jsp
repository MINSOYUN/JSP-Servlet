<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<style type="text/css">
        body {
            background-color: #F9F9F9;
        }

        table {
            width: 90%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table td {
            padding: 10px;
        }

        input[type="text"]{
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
        
  		input[type="submit"], input[type="reset"],
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
        
   		 td[colspan="4"] {
        	text-align: center;
   		 }
</style>

</head>
<body>
<h3>도서 등록하기</h3>
<form name="writeFrm" method="post" action="../book/write.book" enctype="multipart/form-data" onsubmit="return validateForm(this);">
<table border="1" width="90%" style="border-collapse: collapse" height="150px">
    <tr>
        <td>아이디</td>
        <td colspan="4">
            <input type="text" name="id" style="width:90%;" value="${sessionScope.userId }" readonly="readonly" />
        </td>
    </tr>
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="title" style="width:90%;" />
        </td>
        <td>저자명</td>
        <td>
            <input type="text" name="author" style="width:90%;" />
        </td>
    </tr>
    <tr>
        <td>출판사</td>
        <td>
            <input type="text" name="publisher" style="width:90%;" />
        </td>
        <td>대여여부</td>
        <td>
            <input type="text" name="rentyn" style="width:90%;" />
        </td>
    </tr>
    <tr>
        <td>책이미지</td>
        <td  colspan="4">
            <input type="file" name="bookImg" style="width:90%;" />
        </td>
    </tr>
    <tr>
	     <td>상세설명</td>
	     <td colspan="4">
		      <textarea name="info" id="" cols="80" rows="5" ></textarea>
		  </td>
   </tr>
    <tr>
        <td colspan="4" align="center">
            <button type="submit">작성 완료</button>
            <button type="reset">RESET</button>
            <button type="button" onclick="location.href='../mvcboard/list.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>    
</form>
</body>
</html>