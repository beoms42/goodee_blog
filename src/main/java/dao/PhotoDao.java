package dao;

import java.util.ArrayList;
import java.util.HashMap;

import vo.*;
import java.sql.*;
import java.io.File;
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
	public HashMap<String, Object> deletePhoto(int photoNo, String photoPw) throws Exception { 
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//�������ϸ� upload�� �����Ҽ��� ����.. �׷��� �̸� �޾Ƶ־��ҵ�
		Photo ph = selectPhotoOne(photoNo);
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("photoName", ph.photoName);
		
		
		//���� ����  
		String deleteSql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		//�����ϰ�
		PreparedStatement deleteStmt = conn.prepareStatement(deleteSql);
		deleteStmt.setInt(1, photoNo);
		deleteStmt.setString(2, photoPw);
		
		//executeQuery > resultset���� �޾ƾ��ϰ�, update�� �׳� update��, int ��ȯ
		row = deleteStmt.executeUpdate();
		System.out.println(row +"<---------- row");
		hm.put("row", row);
		//���ε� �ȿ� ���ϵ� �����ؾ���.. �ٵ� ���⼭ �����ϴ¹��� �𸣰�,, jsp���� �����ؾ��ҵ�?
		deleteStmt.close();
		conn.close();
		return hm;
	}
	
	// ��ü ���� ��
	public int selectPhotoTotalRow() {
		int total = 0;
		return total;
	}
	
	// �̹��� ���
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Photo ph = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//���� ���� 
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
	
	// �̹��� �ϳ� �󼼺���
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo ph = null;
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		//���� ���� 
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