package hotel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import common.ConnectionUtil;
import dto.Board;
import dto.Member;

public class HotelMemberDao {

	public HotelMemberDao() {
	}

	/**
	 * 로그인 아이디 / 비밀번호가 일치하는 회원을 조회 합니다 회원이 존재하는 경우 Member 객체 반환 존재하지 않는 경우 null 반환
	 * 
	 * @param id : 입력한 회원 id
	 * @param pw : 입력한 회원 pw
	 * @return
	 */
	public Member login(String id, String pw) {
		Member member = null;
		String sql = "select * from member where id= ? and pass = ?";

		// 리소스 / 자원 자동 반환(close)
		try (Connection con = ConnectionUtil.getConnection();
				PreparedStatement psmt = con.prepareStatement(sql);) {
			psmt.setString(1, id);
			psmt.setString(2, pw);
			
			ResultSet rs = psmt.executeQuery();
			// id, pw 일치하는 회원이 있으면 조회
			if (rs.next()) {
				String loginId = rs.getString("id");
				String name = rs.getString("name");
				String regidate = rs.getString("regidate");
				member = new Member(loginId, "", name, regidate);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return member;
	}

	/**
	 * 회원등록
	 * 
	 * @param member
	 * @return 몇건이 처리되었는지 반환
	 */
	// executeUpdate 반환은 int 이기 때문
	public int insert(Member member) {
		int i = 0;
		String sql = "insert into member values(?, ?, ?, sysdate)";
		try (Connection conn = ConnectionUtil.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql);) {
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPass());
			pstmt.setString(3, member.getName());

			i = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return i;
	}
	
}
