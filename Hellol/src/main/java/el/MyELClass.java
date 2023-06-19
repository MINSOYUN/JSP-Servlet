package el;

public class MyELClass {
	
	// 주민번호를 받아 성별을 반환하는 메서드
	public String getGender(String jumin) {
		String res = "";
		try {
			// 문자열의 위치 확인
			System.out.println(jumin.indexOf("-") + 1);
			int startIndex = jumin.indexOf("-") + 1;   // "-" 기준으로 다음 문자열의 위치
			int endIndex = startIndex + 1;   // startIndex을 기준으로 다음 문자열의 위치
			String gender = jumin.substring(startIndex, endIndex);   // str.substring(7, 8)
			
			if(gender.equals("1") || gender.equals("3")) {
				res = "남자";
			} else if(gender.equals("2") || gender.equals("4")) {
				res = "여자";
			} else {
				// 예외를 발생
				throw new Exception();
			}
			
		} catch (Exception e) {
			res = "주민등록 번호를 확인 해주세요!";
		}
		
			return res;
	}

	
	// 입력받은 문자열이 숫자인지 판별하는 정적메서드
	public static boolean isNumber(String value) {
//	    try {
//	        Integer.parseInt(value);
//	        return true;
//	    } catch (NumberFormatException e) {
//	        return false;
//	    }
	    
		// 입력된 문자열을 char 배열로 반환
		char[] chArr = value.toCharArray();  // value 한 글자씩 받아와 char 배열 형태로 반환
		
		for(int i = 0; i<chArr.length; i++) {
			// 문자가 포함되어 있으면 return false;
			if(!(chArr[i] >= '0' && chArr[i] <= '9')) {
				 return false;
			} 
		}
		return true;
	}

	
	// 입력받은 정수까지 구구단을 HTML 테이블로 출력합니다
	// 1~입력받은 숫자까지 출력
	public static String showGugudan(int limitDan) {
		StringBuffer sb = new StringBuffer();
		
	    sb.append("<table border='1'>");
	    
	    for (int dan = 2; dan <= limitDan; dan++) {
	    	sb.append("<tr>");
	        for (int i = 1; i <= 9; i++) {
	        	sb.append("<td>");
	        	sb.append(dan + "*" + i + "=" + (dan*i));
	        	sb.append("</td>");
	        }
	        sb.append("</tr>");
	    }
	    sb.append("</table>");
	    
	    return sb.toString();
	}
	
	
	// 실행
	public static void main(String[] args) {
		MyELClass el = new MyELClass();
		//System.out.println(el.getGender("960902-2000000"));

		// 정적 메서드 사용하는 방법 : 클래스명.메서드명
		System.out.println(MyELClass.isNumber("123"));   // "123" true
		System.out.println(MyELClass.showGugudan(7));

		}

}
