package dao;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;
import java.sql.*;
import java.io.File;
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
	public HashMap<String, Object> deletePhoto(int photoNo, String photoPw) throws Exception { 
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//삭제당하면 upload를 삭제할수가 없음.. 그래서 미리 받아둬야할듯
		Photo ph = selectPhotoOne(photoNo);
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("photoName", ph.photoName);
		
		
		//쿼리 연결  
		String deleteSql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		//삭제하고
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setInt(1, photoNo);
		deleteStmt.setString(2, photoPw);
		
		//executeQuery > resultset으로 받아야하고, update는 그냥 update로, int 반환
		row = deleteStmt.executeUpdate();
		System.out.println(row +"<---------- row");
		hm.put("row", row);
		//업로드 안에 파일도 삭제해야함.. 근데 여기서 삭제하는법은 모르고,, jsp에서 삭제해야할듯?
		deleteStmt.close();
		conn.close();
		return hm;
	}
	
	// 전체 행의 수
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// 이미지 목록
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Photo ph = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//쿼리 연결 
		String insertSql = "select * from photo LIMIT ?, ?";
		
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		
		insertStmt.setInt(1, beginRow);
		insertStmt.setInt(2, rowPerPage);
		
		ResultSet insertRs = insertStmt.executeQuery();
		
		while(insertRs.next()) {
			ph  = new Photo();
			ph.photoName = insertRs.getString("photo_name");
			System.out.println(ph.photoName +" < --------- ph.photoName222222222222");
			ph.photoNo = insertRs.getInt("photo_no");
			ph.photoOriginalName = insertRs.getString("photo_original");
			ph.photoType = insertRs.getString("photo_type");
			ph.writer = insertRs.getString("writer");
			
			list.add(ph);
		}
		
		for(Photo s  : list) {
			System.out.println(s.photoName+"33333333333333");
		}
		return list;
	}
	
	// 이미지 하나 상세보기
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo ph = null;
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//쿼리 연결 
		String insertSql = "select * from photo where photo_No = ?";
		
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setInt(1, photoNo);
		
		ResultSet insertRs = insertStmt.executeQuery();
		
		if(insertRs.next()) {
			ph = new Photo();
			
			ph.photoName = insertRs.getString("photo_name");
			ph.photoNo = insertRs.getInt("photo_no");
			ph.photoOriginalName = insertRs.getString("photo_original");
			ph.photoType = insertRs.getString("photo_type");
			ph.writer = insertRs.getString("writer");
		}
		return ph;
	}
}