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
        if (form.id.value == "") {
            alert("작성자를 입력하세요.");
            form.name.focus();
            return false;
        }
        if (form.name.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.pw.value == "") {
            alert("내용을 입력하세요.");
            form.content.focus();
            return false;
        }
        if (form.adminyn.value == "") {
            alert("비밀번호를 입력하세요.");
            form.pass.focus();
            return false;
        }
    }
</script>
</head>
<body>
<h3>관리자 등록하기</h3>

<form name="registerFrom" method="post"
      action="../member/register.member" onsubmit="return validateForm(this);">
<table border="2" width="90%" height = 100px; style="border-collapse: collapse">
    <tr>
        <td>아이디</td> <td><input type="text" name="id" style="width:90%;" /></td>
        <td>비밀번호</td> <td><input type="text" name="pw" style="width:90%;" /></td>
    </tr>
    <tr>
        <td>이름</td> <td colspan="4"><input type="name" name="title" style="width:90%;" /></td>
    </tr>
    <tr>
        <td>관리자여부(Y/N)</td><td td colspan="4"><input type="text" name="adminyn" style="width:90%;" /></td>
    </tr>
</table>

<table border="1" width="90%">
    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
             <button type="submit"> 등록하기 </button>
             <button type="reset">RESET</button>
             
            </button>
            <button type="button" onclick="location.href='../book/list.book';">
                목록 바로가기
            </button>
       </td>
     </tr>       
</table>
</form>
</body>
</html>
