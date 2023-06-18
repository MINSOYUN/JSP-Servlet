<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
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
	
	<%
	String num = request.getParameter("num");
	BoardDao dao = new BoardDao();
	Board board = dao.selectOne(num);
	%>
	
<h3>수정하기</h3>
<form name= "EditFrm" action="EditProcess.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>"/>
<table border="1" width="90%">
		<tr>
			<th>제목</th>
			<td><input type="text" value="<%=board.getTitle() %>" name="title" style="width:90%;"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea name = "content" style="width:90%; height:100px;"><%=board.getContent() %></textarea></td>
		</tr>
		<tr>
			<td colspan="2"  align="center">
				<button type="submit">수정 완료</button>
				<button type="reset">초기화</button>
				<button type="button" onClick="location.href='Board.jsp'">목록 보기</button>
			</td>
		</tr>
</table>
</form>
</body>
</html>