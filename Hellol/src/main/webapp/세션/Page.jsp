<%@page import="dto.PageDto"%>
<%@page import="dao.Criteria"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	function go(page){
		location.href="PageNavi.jsp?pageNo="+page;
	}
</script>


<%
	// request.getParameter 는 String 타입을 반환하므로 int 타입으로 형변환
	int pageNo = request.getParameter("pageNo") == null ? 1 : 
		Integer.parseInt(request.getParameter("pageNo"));

	// ex) 페이지 번호(2) 받아와서 startNo(1), endNo(10) 설정
	// pageNo을 받아온 변수 pageNo를 매개변수에 작성 -> int 타입
	Criteria criteria = new Criteria(pageNo);
	// total 300 -> 1p에 글 10개 총 30p = 1블럭에 10개 p 총 3개 블럭
	int total = 300;
	
	// 페이지블럭 초기화
	// startNo, endNo, prev, next, realEnd
	PageDto pageDto = new PageDto(total, criteria);
	
	// 이전 페이지 블럭 <
	// booelan 타입이라 isPrev
	// pageDto() 를 사용해 현재 페이지가 1페이지보다 큰 경우에만 true -> '<' 버튼 보인다
	if(pageDto.isPrev()){
		// 제일 앞으로 go(1페이지)
		out.print("<input type='button' value='<<' onclick = 'go(1)''>");
		// 현재 블럭 맨 앞페이지의 앞페이지로 이동하는 것 -> 전 페이지블럭으로 이동
		out.print("<input type='button' value='<' onclick = 'go("+(pageDto.getStartNo()-1)+")'>");
	}
	
	// 1~6
	for(int i= pageDto.getStartNo() ; i<=pageDto.getEndNo(); i++){
		out.print("<input type='button' value='" + i + "' onclick='go("+i+")'>");
	}
	
	// 다음 버튼
	// 페이지블럭의 끝번호와 진짜페이지 번호가 같다면(==) 다음 페이지가 없으므로 false
	if(pageDto.isNext()){
		// 현재 블럭의 마지막 페이지의 다음 페잊이 -> 다음 블럭으로 이동
		out.print("<input type='button' value='>' onclick = 'go("+(pageDto.getEndNo()+1)+")'>");
		// 제일 끝으로
		out.print("<input type='button' value='>>' onclick = 'go("+(pageDto.getRealEnd())+")''>");
	}
%>
</body>
</html>