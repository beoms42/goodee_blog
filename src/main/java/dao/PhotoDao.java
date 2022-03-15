package dao;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;
import java.sql.*;

import vo.Photo;

public class PhotoDao {
	// 이미지 입력
	public void insertPhoto(Photo ph) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//쿼리 연결 - 카테고리용 / 선택 10개 / 비선택 10개 
		String insertSql = "insert into photo(photo_name, photo_original, photo_type, photo_pw, writer, create_date, update_date) values(?, ?, ?, ?, ?, now(), now())";
		
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, ph.photoName);
		insertStmt.setString(2, ph.photoOriginalName);
		insertStmt.setString(3, ph.photoType);
		insertStmt.setString(4, ph.photoPw);
		insertStmt.setString(5, ph.writer);
		
		ResultSet insertRs = insertStmt.executeQuery();
	}
	
	// 이미지 삭제
	public int deletePhoto(int photoNo, String photoPw) { 
		int row = 0;
		return row;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Photo ph = ph = new Photo();
		
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//쿼리 연결 
		String insertSql = "select * from photo order by photo_no DESC LIMIT ?, ?";
		
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		
		insertStmt.setInt(1, beginRow);
		insertStmt.setInt(2, rowPerPage);
		
		ResultSet insertRs = insertStmt.executeQuery();
		
		while(insertRs.next()) {
			
			ph.photoName = insertRs.getString("photo_name");
			ph.photoNo = insertRs.getInt("photo_no");
			ph.photoOriginalName = insertRs.getString("photo_original");
			ph.photoType = insertRs.getString("photo_type");
			ph.writer = insertRs.getString("writer");
			
			list.add(ph);
		}
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) {
		Photo photo = null;
		return photo;
	}
}