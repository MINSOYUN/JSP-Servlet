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
	
<h3>호텔 추가</h3>
<form name= "writeFrm" action="WriteProcess.jsp" method="post" onsubmit="return validateForm(this);">
	<table border="1" width="70%">
		<tr>
			<th>호텔 이름</th>
			<td><input type="text" name="title" style="width:70%;"></td>
		</tr>
		<tr>
			<th>호텔 성급</th>
			<td>
				<select name="searchFiled"> 
					<option value="title">5성급</option> 
					<option value="title">4성급</option> 
					<option value="title">3성급</option> 
				</select>
			</td>
		</tr>
		<tr>
			<th>호텔주소</th>
			<td><textarea name = "content" style="width:70%; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2"  align="center">
				<button type="submit">작성 완료</button>
				<button type="reset">다시 입력</button>
				<button type="button" onClick="location.href='Hotel.jsp'">목록 보기</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>