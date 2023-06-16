<%@page import="dao.Criteria"%>
<%@page import="dao.NewBoardDao"%>
<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>


<%
NewBoardDao dao = new NewBoardDao();
Board board = dao.selectOne(request.getParameter("num"));
dao.updateVisitCount(request.getParameter("num"));


if(board == null){
	JSFunction.alertBack("게시글이 존재하지 않습니다", out);
	return;
}
%>


<script>
function deletePost(){
	var res = confirm("삭제 하시겠습니까>?");
	if(res){
		location.href="DeleteProcess.jsp?num=<%=board.getNum()%>";
	}
}
</script>
</head>
<body>


<h2>회원제 게시판 - 상세 보기(View)</h2>

    <table border="1" width="90%">
        <tr>
            <td>번호</td>
            <td><%=board.getNum() %></td>
            <td>작성자</td>
            <td><%=board.getId() %></td>
        </tr>
        <tr>
            <td>작성일</td>
            <td><%=board.getPostdate() %></td>
            <td>조회수</td>
            <td><%=board.getVisitcount() %></td>
        </tr>
        <tr>
            <td>제목</td>
            <td colspan="3"><%=board.getTitle() %></td>
        </tr>
        <tr>
            <td>내용</td>
            <td colspan="3" height="100">
            <%=board.getContent().replace("\r\n","<br>") %>
            </td> 
        </tr>
        <tr>
            <td colspan="4" align="center">
            
            <%
            if(session.getAttribute("user_id") != null && board.getId().equals(session.getAttribute("user_id"))){
            %>
                <button type="button" onclick="location.href='Edit.jsp?num=<%=board.getNum()%>'">수정하기</button>
                <button type="button" onclick="deletePost()">삭제하기</button> 
                <% }
            	
            	// 주소표시줄의 형태는 문자열 형태이므로 String으로!
                String pageNo = "1";
                if(request.getParameter("pageNo") != null){
                	pageNo = request.getParameter("pageNo");
                }
                %>
                <button type="button" onclick="location.href='List.jsp?pageNo=<%=pageNo%>'">목록 보기</button>
            </td>
        </tr>
    </table>

</body>
</html>
