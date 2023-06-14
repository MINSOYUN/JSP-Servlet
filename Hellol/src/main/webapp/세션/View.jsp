<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%
	BoardDao dao = new BoardDao();  // <script>에서 참조하기 위해 제일 위에 올려준다
	// 게시글 1건 조회 후 board 객체에 담아서 반환
	dao.updateVisitCount(request.getParameter("num"));  // 조회수 + 1
	Board board = dao.selectOne(request.getParameter("num"));
	
	
	if(board == null){
		JSFunction.alertBack("게시글이 존재하지 않습니다.", out);
		// out.print("<script>");
		// out.print("alert('게시글이 존재하지 않습니다')");
		// out.print("history.go(-1);");
		// out.print("</script>");
		
		return;
	} 
%>

<script>
	function deletePost(){
		 var res = confirm("삭제 하시겠습니까?");
		 if(res){
			 location.href="DeleteProcess.jsp?num=<%= board.getNum()%>";
		 }
	}
</script>
</head>
<body>
<h3>회원제 게시판 - 상세 보기(View)</h3>
<form>
	<table border="1" width="90%">
		<tr>
			<th>번호</th>
			<td colspan="2"><%=board.getNum() %></td>
			<th>작성자</th>
			<td><%=board.getId() %></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td colspan="2"><%=board.getPostdate() %></td>
			<th>조회수</th>
			<td><%=board.getVisitcount()%></td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="4"><%=board.getTitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="4" ><textarea name = "content" style="width:90%; height:100px;"><%=board.getContent() %></textarea></td>
		</tr>
		<tr align="center">
			<td colspan="5">
				<button type="button" onClick="location.href='Board.jsp'">목록 보기</button>
				<%
				// 로그인한 아이디와 글쓴이가 같으면 수정, 삭제 버튼 활성화
				if(session.getAttribute("user_id") != null && board.getId().equals(session.getAttribute("user_id"))){ %>
				<button type="button" onclick="location.href='Edit.jsp?num<%= board.getNum()%>'">수정하기</button>
				<button type="button" onclick="">삭제하기</button>
				<% } %>
			</td>
		</tr>
	</table>
</form>
</body>
</html>