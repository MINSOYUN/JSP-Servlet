package fileupload;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;

public class FileDao {

	public FileDao() {
		// TODO Auto-generated constructor stub
	}
	
	// 파일 정보 저장
	public int insertFile(FileDto dto) {
		int res = 0;
		String sql = "insert into myfile (idx, name, title, cate, ofile, sfile) values (seq_board_num.nextval, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCate());
			pstmt.setString(4, dto.getOfile());
			pstmt.setString(5, dto.getSfile());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	
	// 파일 목록 조회
	public List<FileDto> getFileList(){
		List<FileDto> list = new ArrayList<FileDto>();
		FileDto dto = null;
		String sql = "select * from myfile order by idx desc";
		
		try (Connection conn =  DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				dto = new FileDto();
				dto.setIdx(rs.getString("idx"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setCate(rs.getString("cate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setPostdate(rs.getString("postdate"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
}
