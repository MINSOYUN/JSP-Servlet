<%@page import="dao.NewBoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>

</head>
<body>
<jsp:include page="../세션/Link.jsp"/>
<%
	String num = request.getParameter("num");
	NewBoardDao dao = new NewBoardDao();
	Board board = dao.selectOne(num);
%>

<h2>회원제 게시판 - 수정하기(Edit)</h2>
<form action="EditProcess.jsp" method="post" name="EditForm"></form>
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%=board.getTitle()%>"/> 
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"><%=board.getContent() %></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp'">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>