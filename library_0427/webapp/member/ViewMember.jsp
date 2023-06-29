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
    <h3>회원 상세보기</h3>
	회원아이디 : <input type="text" name="no" value="${member.id }">
	
    <form name="writeFrm" method="post" action="../member/write.member" enctype="multipart/form-data"
        onsubmit="return validateForm(this);">
        <table border="1" height="200">
            <tr>
                <td>아이디</td>
                <td>
               		${ member.id }
                </td>
                <td>비밀번호</td>
                <td>
					${ member.pw }
                </td>
            </tr>
            <tr>
                <td>이름</td>
                <td colspan="3">
                   ${ member.name }
                </td>
            </tr>
            <tr>
                <td>관리자여부</td>
                <td colspan="3">
                   ${ member.adminyn }
                </td>
            </tr>
            <tr>
                <td>상태</td>
                <td>
                    ${ member.status }
                </td>
                <td>등급</td>
        		<td>
          			 ${ member.grade }
       			</td>
       		</tr>
   			 <tr>
		         <td>자기소개</td>
		     	 <td colspan="4">
			             <textarea name="" id="" cols="100" rows="10" readonly>${ member.info }</textarea>
			     </td>
   			</tr>
		    <tr>
		        <td colspan="4" align="center">
		            <button type="button" onclick="location.href='./edit.member?id=${member.id}';">
	                수정하기
		            </button>
		            <button type="button" onclick="location.href='./delete.member?delNo=${ member.id }';">
		            	삭제하기
		            </button>
		            <button type="button" onclick="location.href='./listMember.member';">
		                회원 목록 바로가기
		            </button>
		        </td>
		    </tr>
</table>    
</form>
