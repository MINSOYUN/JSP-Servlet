<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="Link.jsp" />
	
	<h3>회원제 게시판 - 글쓰기(Write)</h3>
	<form name= "writeFrm" action="WriteProcess.jsp" method="post" onsubmit="return validateForm(this);">
	<table border="1" width="90%">
		<tr>
		<th>제목</th>
		<td><input type="text" name="title" style="width:90%;"></td>
		</tr>
		<tr>
		<th>내용</th>
		<td><textarea name = "content" style="width:90%; height:100px;"></textarea></td>
		</tr>
		<tr>
		<td colspan="2"  align="center">
			<button type="submit">작성 완료</button>
			<button type="reset">다시 입력</button>
			<button type="button" onClick="location.href='Board.jsp'">목록 보기</button>
		</td>
		</tr>
	</table>
	</form>
</body>
</html>