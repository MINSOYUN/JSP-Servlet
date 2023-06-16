<%@page import="dto.PageDto"%>
<%@page import="dao.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
<%     
    String searchFiled = request.getParameter("searchFiled");
    String searchWord = request.getParameter("searchWord");
    // 요청한 페이지 번호가 없다면 기본 페이지인 1p 를 보여준다
    int pageNo = request.getParameter("pageNo") == null ? 1 : Integer.parseInt(request.getParameter("pageNo"));
    
    // 검색어가 null인 경우 공백 출력
    searchWord = searchWord == null ? "": searchWord;
    /*if(searchWord == null){
    	searchWord = "";
    } */
    
    // 검색어가 null이 아니면 검색 기능을 추가
    out.print("검색어: " + searchFiled+"<br>");
	out.print("검색필드: " + searchWord);

   	// 검색 조건 객체로 생성
    Criteria criteria = new Criteria(searchFiled, searchWord, pageNo);
   	
   	// 게시판 DB 작업 - DAO 생성
   	BoardDao dao = new BoardDao();

	// 리스트 조회
    // List<Board> boardList = dao.getList(searchFiled, searchWord); 
   	List<Board> boardList = dao.getListPage(criteria);
    
    // 총 건수 조회 
    int totalCnt = dao.getToatlCnt(criteria);
%>


<jsp:include page="Link.jsp"></jsp:include>

<h3>목록보기(List)</h3>
총건수: <%=totalCnt %>

<!-- 검색폼 -->
<form name='searchForm'> 
<input type='text' name='pageNo' value='<%=criteria.getPageNo()%>'>
	<table border=1 width="90%">
		<tr align="center">
		  <td>
			<select name="searchFiled"> <!-- name 값으로 선택하기 때문에 -->
				<option value="title">제목</option> <!-- 넘어갈 때 value 값으로 넘어가기때문에 value 지정하기 -->
				<option value="content">내용</option>
			</select>
				<input type="text" name="searchWord" value="<%= criteria.getSearchWord()%>">
				<input type="submit" value="검색하기">
		  </td>
		</tr>
	</table>
</form>
<!-- 검색폼 끝 -->

<table border="1" width="90%">
	<tr>
		<th>번호</th> 
		<th>제목</th>
		<th>내용</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	<%
	if(boardList.isEmpty()){   //  컬렉션 또는 문자열이 비어 있는지 확인하는 메서드
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
		<td><a href="View.jsp?num=<%=board.getNum()%>"><%=board.getTitle() %></a></td>
		<td><%=board.getContent()%></td>
		<td><%=board.getId()%> </td>
		<td><%=board.getPostdate() %></td>
		<td><%=board.getVisitcount() %></td>
	</tr>
	<%
		}
	} %>
	
</table>


<%
   if(session.getAttribute("user_id") != null){
%>
<table border=1 width="90%">
    <tr>
		<td align="right">
		  	<input type="button" value="글쓰기" onclick="location.href='Write.jsp'">
		</td>
	</tr>
</table>
<% } %>


<!-- 페이지블럭 생성 -->
<%
	// totalCnt 상단에 정의해둠
	// 파라미터 초기화 잘 되었는지 확인
	PageDto pageDto = new PageDto(totalCnt, criteria);
%>
<table border=1 width="90%">
    <tr>
		<td align="center">
		<!-- 인클루드 -->
			<%@include file="PageNavi.jsp" %>
		</td>
	</tr>
</table>
		  
  
</body>
</html>