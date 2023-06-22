<%@page import="fileupload.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="fileupload.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:set var="fileList" value=" ${requestScope.list }"/>

<h4>DB에 등록된 파일 목록 보기</h4>
<a href = "FileUpload.jsp">파일 등록 하기</a>

<c:set var="fileList" value="${requestScope.list }"/>

<table border="1" width="95%" style="border-collapse: collapse;">

	<tr>
	    <th>일련번호</th>
	    <th>작성자</th>
	    <th>제목</th>
	    <th>카테고리</th>
	    <th>원본 파일명</th>
	    <th>저장된 파일명</th>
	    <th>날짜</th>
	    <th>다운로드</th>
	</tr>
	
	<c:if test="${empty fileList}" var="notfile">
		<tr>
			<td colspan="7">등록된 파일이 없습니다</td>
		</tr>
	</c:if>
	
	<c:if test="${notfile ne true}">
	<c:forEach items="${fileList }" var="fileDto">
		<tr align="center">
		    <td>${fileDto.idx }</td>
		    <td>${fileDto.name }</td>
		    <td>${fileDto.title }</td>
		    <td>${fileDto.cate }</td>
		    <td>${fileDto.ofile }</td>
		    <td>${fileDto.sfile }</td>
		    <td>${fileDto.postdate }</td>
		    <td>
			    <a href="Download.jsp?oName=${fileDto.ofile }&sName=${fileDto.sfile}">다운로드</a>
		    </td>
		</tr>
	</c:forEach>
	</c:if>
</table>

</body>
</html>