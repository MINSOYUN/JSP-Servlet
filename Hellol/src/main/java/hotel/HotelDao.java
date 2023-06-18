package hotel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import common.DBConnPool;

public class HotelDao {
	
	
	// 조회
	public List<Hotel> getList(String searchFiled, String searchWord){
		Hotel hotel = null;
		List<Hotel> hotelList = new ArrayList<Hotel>();

		String sql = "select * from hotel ";
		if(searchWord != null && !"".equals(searchWord)) {
			sql += " where " + searchFiled + " like '%" + searchWord + "%'";
		}
		sql += " order by num desc";
		
		try (Connection conn = DBConnPool.getConnection();
				Statement stmt = conn.createStatement();){
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				hotel = new Hotel();
				
				hotel.setNum(rs.getString("num"));
				hotel.setName(rs.getString("name"));
				hotel.setStar(rs.getString("star"));
				hotel.setId(rs.getString("id"));
				hotel.setAddress(rs.getString("address"));
				hotel.setPostdate(rs.getString("postdate"));
				
				hotelList.add(hotel);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 조회 중 에러 발생하였습니다");
		}
		return hotelList;
	}
	
	
	// 1건 조회
	public Hotel selectOne(String num) {
		Hotel hotel = null;
		String sql = "select * from hotel where num = ?";
		
		if(num == null || "".equals(num)) {
			return null;
		}
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				hotel = new Hotel();
				
				hotel.setNum(rs.getString("num"));
				hotel.setName(rs.getString("name"));
				hotel.setStar(rs.getString("star"));
				hotel.setId(rs.getString("id"));
				hotel.setAddress(rs.getString("address"));
				hotel.setPostdate(rs.getString("postdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 1건 조회 도중 오류가 발생하였습니다");
		}
		return hotel;
	}
	
	
	// 호텔등록
	public int insertHotel(Hotel hotel) {
		int res = 0;
		String sql = "insert into hotel values (seq_hotel_num.nextval, ?, ?, ?, ?, sysdate)";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			// 왜 getParameter 가 아닌 hotel.___ 인지 =========================
			pstmt.setString(1, hotel.getName());
			pstmt.setString(2, hotel.getStar());
			pstmt.setString(3, hotel.getId());
			pstmt.setString(4, hotel.getAddress());
			
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 등록 도중 오류가 발생하였습니다");
		}
		return res;
	}
	
	
	// 총 검색갯수
	public int getTotalCnt(String searchFiled, String searchWord) {
		int totalCnt = 0;
		String sql = "select count(*) from hotel ";
		
		if(searchWord != null && "".equals(searchWord)) {
			sql += " where " + searchFiled + " like '%" + searchWord + "%'";
		}
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			ResultSet rs = pstmt.executeQuery();
			
			rs.next();
			// 갯수를 가져오기 위해 getInt 사용
			totalCnt = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 수를 조회하던 중 예외가 발생하였습니다");
		}
		return totalCnt;
	}
	
	public int delete(String num) {
		int res = 0;
		String sql = "delete from hotel where num= ?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, num);
			res =pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 삭제 도중 오류가 발생하였습니다");
		}
		 return res;
	}
	
	public int update(Hotel hotel){
		int res = 0;
		String sql ="update hotel set name =?, star=?, address=? where num=?";
		
		try (Connection conn = DBConnPool.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);){
			pstmt.setString(1, hotel.getName());
			pstmt.setString(2, hotel.getStar());
			pstmt.setString(3, hotel.getAddress());
			pstmt.setString(4, hotel.getNum());
			
			res = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("호텔 수정 도중 오류가 발생하였습니다");
		}
		return res;
	}
}
