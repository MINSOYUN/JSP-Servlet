<%@page import="com.library.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<style>
		.container {
			max-width: 600px;
			margin: 0 auto;
			padding: 20px;
			text-align: center;
		}

		h2 {
			font-size: 24px;
			margin-bottom: 20px;
		}

		.menu {
			  display: flex;
			  flex-direction: column;
			  align-items: center;
			  list-style: none;
			  padding: 0;
			  margin-bottom: 30px;
			}
			
		.menu li {
			  margin-bottom: 10px;
			  padding: 20px 0px;
			}
			
		.menu a {
			  text-decoration: none;
			  padding: 5px 10px;
			  border: 1px solid #ccc;
			  border-radius: 5px;
			  color: #333;
			}
			
		.menu a:hover {
			  background-color: #f0f0f0;
			}


		/* Buttons */
		.button {
			display: inline-block;
			padding: 10px 20px;
			margin: 0px 20px;
			border: none;
			border-radius: 5px;
			background-color: #fad96f;
			color: #fff;
			font-size: 16px;
			font-weight: bold;
		}

		.button:hover {
			color: #333333cc;
			color: #333;
			font-weight: bold;
		}
	</style>
</head>
<body>
<%@ include file = "/common/header.jsp" %>
<%
 if(session.getAttribute("member") != null){
	 Member m = (Member)session.getAttribute("member");
%>
	<div class="container">
		<h2>관리자 사용자 관리</h2>
		<ul class="menu">
			<li><a href="./member/listMember.member">회원 목록 보기</a></li> 
			<li><a href="./member/write.member">회원 등록[바로가기]</a></li> 
			<li><a href="./member/delete.member">회원 삭제</a></li>
			<li><a href="./book/list.book">회원 관리 창 나가기</a></li>
			<button class="button" onclick="location.href='logout.jsp'">로그아웃</button>
		</ul>
<% } %>
<%
 if(session.getAttribute("member") == null){
	 Member m = (Member)session.getAttribute("member");
%>
			<button class="button" onclick="location.href='login.jsp'">로그인</button>
<% } %>
	</div>
</body>
</html>
