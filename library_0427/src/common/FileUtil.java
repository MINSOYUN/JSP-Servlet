package common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.PageContext;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	public static void download(HttpServletRequest req, HttpServletResponse resp, String saveDirectory, String originalFilename, String saveFileName) {
		//업로드파일이 저장된 경로
//		// 원본 파일이름
//		String originalFilename = req.getParameter("oName");
//		// 저장된 파일이름
//		String saveFileName = req.getParameter("sName");
		
		System.out.println("ofileName : " + originalFilename + "<br>");
		System.out.println("sfileName : " + saveFileName+ "<br>");
		
		try{
			File file = new File(saveDirectory, saveFileName);
			
			// 파일 입력 스트림 생성
			InputStream inStream = new FileInputStream(file);
			
			// 한글 파일명 깨짐 방지
		    String client = req.getHeader("User-Agent");
			// ie체크
		    if (client.indexOf("WOW64") == -1) {
		        originalFilename = 
	     		new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
		    }
		    else {
		        originalFilename = 
	     		new String(originalFilename.getBytes("KSC5601"), "ISO-8859-1");
		    }
			
			
			// 파일 다운로드용 응답 헤더 설정 
		    resp.reset();
			
			// 파일 다운로드 창을 띄우기 위한 콘텐츠 타입을 지정
			// octet-stream은 8비트 단위의 바이너리 데이터를 의미
		    resp.setContentType("application/octet-stream");
			
			// 원본파일이름으로 다운로드 받을수 있게 설정 하는 부분
		    resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalFilename + "\"");
		    resp.setHeader("Content-Length", "" + file.length() );

		    
		    // response 내장 객체로 부터 새로운 출력 스트림을 생성
		    OutputStream outStream = resp.getOutputStream();
		    
		    // 출력 스트림에 파일 내용 출력
		    byte b[] = new byte[(int)file.length()];
		    int readBuffer = 0;    
		    while ( (readBuffer = inStream.read(b)) > 0 ) {
		        outStream.write(b, 0, readBuffer);
		    }
		    
		    // 입/출력 스트림 닫음;
		    inStream.close();
		    outStream.close();
		}
		catch (FileNotFoundException e) {
		    JSFunction.alertBack(resp, "파일을 찾을 수 없습니다");
		}
		catch (Exception e){
			JSFunction.alertBack(resp, "파일 다운로드 중 오류가 발생 하였습니다");
		}
	}
	
		
		/**
		 * 파일 업로드(multipart/form-data 요청) 처리
		 */
		public static MultipartRequest uploadFile(HttpServletRequest req, String saveDirectory, int maxPostSize) {
			
			try {
				// 파일 업로드
				return new MultipartRequest(req, saveDirectory, maxPostSize, "UTF-8");
			
			} catch(IOException e){
				e.printStackTrace();
				return null;
				
			}
		}
		
		/**
		 * 파일 삭제
		 */
		public static void deleteFile(String directory, String filename) {
			File file = new File(directory + File.separator + filename);
			// 파일이 존재하면 제거
			if(file.exists()) {
				file.delete();
			}
		}
		
		
		/**
		 * 파일명 받아와 새 파일명으로 변경
		 * @return
		 */
		public static String fileNameChange(String saveDirectory, String fileName) {
			String ext = fileName.substring(fileName.lastIndexOf("."));
			
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());  // 현재시간 추출
		    String oFileName = fileName.substring(0, fileName.lastIndexOf("."));  // 확장자 제외한 파일명 추출
			
			String newFileName = oFileName + "_" + now + ext;  // 원본파일명 + 시간 + 확장자
			
			System.out.println("원본파일명 : " + fileName);
			System.out.println("신규파일명 : " + newFileName);
			
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			
			// 파일의 경로와 이름을 재지정하여 경로 포함되어 있는 newFile로 변경 
			oldFile.renameTo(newFile);  // 파일명 변경
			
			return newFileName;
		}
	
	public FileUtil() {

	}

}
