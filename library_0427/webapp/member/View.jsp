<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
	function setAction(action){
		viewForm.action=action;
	}
</script>
</head>
<body>
${map.message  }
<%@include file="/common/header.jsp" %>
<h3>도서 상세보기</h3>

<form name="viewForm" method="post">
<table border="1" style="border-collapse: collapse">
    <colgroup>
        <col width="30%"/> 
        <col width="15%"/> <col width="20%"/>
        <col width="15%"/> <col width="20%"/>
    </colgroup>

    <!-- 게시글 정보 -->
	<tr>
        <td rowspan="4">
        	<img alt="${ member.name }이미지" width="200px" src="../images/memberImg/${member.sfile }">
        </td>
        <td colspan="1">아이디</td><td colspan="2">${ member.id }</td>
        <td colspan="1">설정한 비밀번호</td> <td colspan="2">${ member.pw }</td>
    </tr>
    <tr>
        <td colspan="1">이름</td> <td colspan="5">${ member.name }</td>
    </tr>
    <tr>
        <td colspan="1">관리자여부</td> <td colspan="1">${ member.adminyn }</td>
        <td colspan="1">상태</td> <td colspan="1">${ member.status }</td>
        <td colspan="1">등급</td> <td colspan="1">${ member.grade }</td>
    </tr>
    <tr>
    	<td height="200px">자기소개</td><td colspan="3"></td>
    </tr>


    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="5" align="center">
            <button type="button" onclick="location.href='./edit.member?no=${member.id}';">
                수정하기
            </button>
            <button type="button" onclick="location.href='./delete.member?delNo=${ member.id }';">
            	삭제하기
            </button>
            <button type="button" onclick="location.href='./list.member';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
