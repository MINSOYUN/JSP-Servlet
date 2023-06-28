<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
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
        if (form.pass.value == "") {
            alert("비밀번호를 입력하세요.");
            form.pass.focus();
            return false;
        }
    }
</script>
</head>
<h3>도서 등록하기</h3>

<form name="writeFrm" method="post"
      action="../book/write.book" enctype="multipart/form-data" onsubmit="return validateForm(this);">
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
        <td>
            <input type="file" name="bookImg" style="width:90%;" />
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