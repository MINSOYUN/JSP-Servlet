<%@page import="common.JSFunction"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="fileupload.FileDao"%>
<%@page import="fileupload.FileDto"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	// 저장할 디렉터리의 실제 경로
	String saveDirectory = "C:/upload";

	// webapp 폴더 하위에 디렉토리를 생성
	//saveDirectory = "C:/Users/user/git/JSP-Servlet/Hellol/src/main/webapp/업로드";
	
	// 파일의 최대 크기(1MB)
	int maxPostSize = 1024 * 1000;
	
	// 인코딩 방식
	String encoding = "utf-8";
	
	try{
		// 1. MultipartRequest 객체 생성
		// 생성자의 매개변수로 저장경로, 파일의 최대크기 ,인코딩방식을 지정
		// 객체 정상적으로 생성되면 파일은 업로드
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);
		
		// 2. 새로운 파일명 생성
		// 동일한 파일명이 업로드 되는 경우 기존 파일이 소실될 위험이 있으므로 파일명을 변경합니다
		// 한글이 깨지는 경우가 발생할 수 있으므로 영문과 파일명을 숫자의 조합으로 파일명 변경
		String fileName = mr.getFilesystemName("attachedFile");
		
		// 첨부파일의 확장자
		// 마지막 인덱스 . 으로부터 끝까지 문자열 가져와 확장자 추출
		// 파일명에 점(.)이 2개 이상 포함될 수 있기 때문
		String ext = fileName.substring(fileName.lastIndexOf("."));
		
		// H : 0~23 S : millisecond
		// 현재 시간을 파일이름으로 지정
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());  // 현재시간 추출
	    String oFileName = fileName.substring(0, fileName.lastIndexOf("."));  // 확장자 제외한 파일명 추출
		
		String newFileName = oFileName + "_" + now + ext;  // 원본파일명 + 시간 + 확장자
		System.out.println("원본파일명 : " + fileName);
		System.out.println("신규파일명 : " + newFileName);
		
		// 3. 파일명 변경
		// 경로 + 파일의 이름
		// File.separator는 경로를 구분하는 특수 기호
		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		
		oldFile.renameTo(newFile);  // 파일명 변경
		
		
		// 폼 요소의 값을 저장
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		
		// 체크 박스인 경우 배열로 반환 받아서 문자열로 연결해서 저장 getParameterValues
		String[] categoryArr = mr.getParameterValues("category");
		
		StringBuffer sb = new StringBuffer();
		if(categoryArr == null){
			sb.append("선택없음");
		} else{
			for(String category : categoryArr){
				sb.append(category +" ");
			}
		}
	
		System.out.println("name : " + name);
		System.out.println("title : " + title);
		System.out.println("category : " + sb.toString());
		System.out.println("ofileName : " + fileName);
		
		// DTO 생성
		FileDto dto = new FileDto("", name, title, sb.toString(), fileName, newFileName, "");
		
		// DAO를 통해 데이터 베이스에 등록
		FileDao dao = new FileDao();
		int res = dao.insertFile(dto);
		
		if(res>0){
			JSFunction.alertLocation("파일이 등록되었습니다", "FileList.jsp", out);
		} else{
			JSFunction.alertBack("DB 등록에 실패하였습니다", out);
		}
		
	} catch(Exception e){
		request.setAttribute("errorMessage", "파일 업로드 오류");
		out.print(e);
		JSFunction.alertBack("파일 업로드 오류 발생, 관리자에게 문의해주세요", out);
		// 이전페이지로 이동
	}
%>
</body>
</html>