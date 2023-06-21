<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function validationFrom(form){
		if(form.name.value ==''){
			alert("작성자를 입력하세요");
			form.name.focus(); // focus
			return false;
		}
		if(form.title.value ==''){
			alert("제목을 입력해주세요");
			form.title.focus();
			return false;
		}
		if(form.attachedFile.value ==''){
			alert("파일을 첨부해주세요");
			return false;
		}
		if(document.querySelectAll("[name=category]:checked").length == 0){
			alert("카테고리를 선택 해주세요");
			return false;
		}
	
	}
</script>

</head>
<body>
	<h4>파일 업로드</h4>
	<!--
		파일 업로드
		라이브러리 추가 후 form 태그의 속성을 설정
		<< form 태그 속성 설정 >>
		method="post"
		enctype="multipart/form-data"
	 -->
	 
	 <!--
	  유효성 검사, validation 체크
	  사용자 입력 체크 로직 -->
	  ${errorMessage } <!-- 이게 가능한지! -->
	<form action="UploadProcess.jsp" method="post" enctype="multipart/form-data" onsubmit="return validationFrom(this)">
		<p>
			작성자: <input type="text" name="name" value="성함">
		</p>
		<p>
			제목: <input type="text" name="title" value="제목">
		</p>
		<p>
			카테고리: 
			<input type="checkbox" name="category" value="사진" checked>사진
			<input type="checkbox" name="category" value="과제">과제
			<input type="checkbox" name="category" value="워드">워드
			<input type="checkbox" name="category" value="음원">음원
		</p>
		<p>
			첨부파일: <input type="file" name="attachedFile">
		</p>
		
		<input type="submit" value="전송하기">
	</form>
	<!-- 
	enctype : form 값을 서버로 전송할 때의 인코딩 방식을 지정
	application/x-www-form-urlencoded
	- 모든 문자를 서버로 전송하기 위해 인코딩
	
	
	multipart/form-data
	- <form> 태그를 통해 파일을 서버로 전송 할 때 사용. 모든 문자를 인코딩 하지 않습니다
	 -->
	 
	 <h4>다운로드</h4>
	 <a href="${pageContext.request.contextPath}/업로드/05_입력양식 작성하기.pdf" download="파일명">다운로드</a>
</body>
</html>