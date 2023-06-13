<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
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
<% 
	BoardDao dao = new BoardDao();
    List<Board> boardList = dao.getList();
    
    // 총 게시물 수
    int totalCnt = dao.getToatlCnt();
    
    String searchFiled = request.getParameter("searchFiled");
    String searchWord = request.getParameter("searchWord");
    
    // 검색어가 null이 아니면 검색 기능을 추가
    out.print(searchFiled);
    out.print(searchWord);
%>


<jsp:include page="Link.jsp"></jsp:include>

<h3>목록보기(List)</h3>
총건수: <%=totalCnt %>'


<!-- 검색폼 -->
<form>
	<table border=1 width="90%">
		<tr align="center">
		  <td>
			<select name="searchFiled"> <!-- name 값으로 선택하기 때문에 -->
				<option value="title">제목</option> <!-- 넘어갈 때 value 값으로 넘어가기때문에 value 지정하기 -->
				<option value="content">내용</option>
			</select>
				<input type="text" name="searchWord" value="<%= searchWord%>">
				<input type="submit" value="검색하기">
		  </td>
		</tr>
	</table>
</form>
<!-- 검색폼 끝 -->


<table border="1">
	<tr>
		<th>번호</th> 
		<th>제목</th>
		<th>내용</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%
	if(boardList.isEmpty()){
		// 게시글이 하나도 없을 때
	%>
	<tr>
		<td colspan="5" align="center">등록된 게시글이 없습니다</td>
	</tr>	
	<% } else {
			for(Board board : boardList){	
	%>
	<tr>
		<td><%=board.getNum() %></td>
		<td><%=board.getTitle() %></td>
		<td><%=board.getContent()%></td>
		<td><%=board.getId()%> </td>
		<td><%=board.getPostdate() %></td>
		<td><%=board.getVisitcount() %></td>
	</tr>
	<%
		}
	} %>
	
</table>


<table border=1 width="90%">
    <tr>
		<td  align="center">
		  	<input type="text" value="글쓰기">
		 </td>
	</tr>
</table>
		  
  
</body>
</html>