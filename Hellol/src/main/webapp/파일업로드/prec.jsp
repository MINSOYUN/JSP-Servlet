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
	String saveDirectory = "C:/upload";

	int maxPostSize = 1024 * 1000;
	
	String encoding = "utf-8";
	
	try{
		MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxPostSize, encoding);

		String fileName = mr.getFilesystemName("attachedFile");
		

		String ext = fileName.substring(fileName.lastIndexOf("."));
		

		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());  
	    String oFileName = fileName.substring(0, fileName.lastIndexOf(".")); 
		
		String newFileName = oFileName + "_" + now + ext;  
		System.out.println("원본파일명 : " + fileName);
		System.out.println("신규파일명 : " + newFileName);
		

		File oldFile = new File(saveDirectory + File.separator + fileName);
		File newFile = new File(saveDirectory + File.separator + newFileName);
		
		oldFile.renameTo(newFile);  

		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		
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
		
		FileDto dto = new FileDto("", name, title, sb.toString(), fileName, newFileName, "");
		
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
	}
%>
</body>
</html>