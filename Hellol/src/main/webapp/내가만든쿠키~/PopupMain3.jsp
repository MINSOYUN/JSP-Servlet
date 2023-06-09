<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
    .off{
    display: none;
    }
</style>
<script>
window.onload = function(){
	// 버튼이 클릭되면 함수를 실행
	closeBtn.onclick= function(){
		popup.style.display = 'none';
		
		var chkVal = document.querySelector("input[id=inactiveToday]:checked");
		
		// 체크박스가 체크 된 상태라면
		if(chkVal.value == 1 && chkVal != null){
			// javascript를 활용한 쿠키 생성
			const date = new Date();
			// 12시간을 나타낸다
			date.setTime(date.getTime() + 12 * 60 * 60 * 1000);
			document.cookie = "PopupClose=off;expires="+date.toGMTString();
		}
	}
}
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String popupClose = CookieManager.readCookie(request, "PopupClose");
		// 쿠키에 popupClose가 등록되어 있으면(쿠키 있음) 팝업창을 출력하지 않도록 처리
		// off style : display none -> 폼태그 안보여준다
		// "" 이면 보여준다
		String off = popupClose.equals("")? "" : "off";
	%>
	
	<h2>쿠키를 활용한 팝업창 제어 2.0</h2>
	<div id="popup" class = "<%= off%>"> <!-- 보여주고 싶을 때 도 있어서 사용 -->
	       <h2 align="center">공지사항 팝업입니다.</h2>
	       <div align="right">
	        <form name="popFrm">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
	       </div>
	   </div>
	</body>