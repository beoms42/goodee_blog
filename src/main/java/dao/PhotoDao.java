package dao;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;
import java.sql.*;

import vo.Photo;

public class PhotoDao {
	// �̹��� �Է�
	public void insertPhoto(Photo ph) throws Exception {
		
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//���� ���� - ī�װ��� / ���� 10�� / ���� 10�� 
		String insertSql = "insert into photo(photo_name, photo_original, photo_type, photo_pw, writer, create_date, update_date) values(?, ?, ?, ?, ?, now(), now())";
		
		PreparedStatement insertStmt = conn.prepareStatement(insertSql);
		insertStmt.setString(1, ph.photoName);
		insertStmt.setString(2, ph.photoOriginalName);
		insertStmt.setString(3, ph.photoType);
		insertStmt.setString(4, ph.photoPw);
		insertStmt.setString(5, ph.writer);
		
		ResultSet insertRs = insertStmt.executeQuery();
	}
	
	// �̹��� ����
	public int deletePhoto(int photoNo, String photoPw) { 
		int row = 0;
		return row;
	}
	
	// ��ü ���� ��
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// �̹��� ���
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Photo ph = ph = new Photo();
		
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//���� ���� 
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
	
	// �̹��� �ϳ� �󼼺���
	public Photo selectPhotoOne(int photoNo) {
		Photo photo = null;
		return photo;
	}
}