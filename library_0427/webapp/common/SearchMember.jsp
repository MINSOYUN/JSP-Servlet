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
		<table border="1" width="100%">
	<!-- 페이지 번호 -->
		<input type="hidden" name="pageNo"">
		<input type="hidden" name="delNo"">
			<tr>
				<td align="center">
				<select	name="searchField">
						<option value="id" ${param.searchField eq "id" ? "selected" : ""}>id</option>
						<option value= "name" ${param.searchField eq "name" ? "selected" : ""}>이름</option>
				</select>
					<input type="text" name="searchWord"/>
					<input type="submit" value="검색하기" />
				</td>
			</tr>
		</table>
	</form>
</body>
</html>