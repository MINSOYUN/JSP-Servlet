<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <h3>관리자 등록하기</h3>

    <form name="writeFrm" method="post" action="../member/write.member" enctype="multipart/form-data"
        onsubmit="return validateForm(this);">
        <table border="1" height="200">
            <tr>
                <td>아이디</td>
                <td>
                    <input type="text" name="id" placeholder="아이디를 입력하세요." required>
                </td>
                <td>비밀번호</td>
                <td>
                    <input type="text" name="pw" placeholder="비밀번호를 입력하세요." required>
                </td>
            </tr>
            <tr>
                <td>이름</td>
                <td colspan="3">
                    <input type="text" name="name" placeholder="이름(실명)을 입력하세요." required>
                </td>
            </tr>
            <tr>
                <td>관리자여부</td>
                <td colspan="3">
                    <input type="text" name="adminyn" placeholder="관리자일 경우 'Y', 아니면 'N'" required>
                </td>
            </tr>
            <tr>
                <td>상태</td>
                <td>
                    <input type="text" name="status">
                </td>
                <td>등급( A ~ D 등급)</td>
        		<td>
          			  <input type="text" name="grade" style="width:90%;" />
       			</td>
       		</tr>
   			 <tr>
		         <td>사진 첨부</td>
		     	 <td colspan="4">
			            <input type="file" name="memberImg" style="width:90%;" />
			     </td>
   			</tr>
		    <tr>
		        <td colspan="4" align="center">
		            <button type="submit">작성 완료</button>
		            <button type="reset">RESET</button>
		            <button type="button" onclick="location.href='./listMember.member';">
		                목록 바로가기
		            </button>
		        </td>
		    </tr>
</table>    
</form>
