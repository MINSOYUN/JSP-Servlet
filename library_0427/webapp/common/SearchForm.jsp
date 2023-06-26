<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 검색 폼 시작 -->
	<form method="get" name="searchForm">
		<table border="1" width="90%">
	<!-- 페이지 번호 -->
		<input type="hidden" name="pageNo"">
			<tr>
				<td align="center">
				<select	name="searchField">
						<option value="title">제목</option>
						<option value=name">저자</option>
				</select>
					<input type="text" name="searchWord"" />
					<input type="submit" value="검색하기" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>