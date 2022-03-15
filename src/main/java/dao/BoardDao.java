package dao;

import java.util.ArrayList;
import java.util.HashMap;


import vo.Board;
import java.sql.*;

public class BoardDao {
	public BoardDao() {}
	
	//ī�װ� ���� �޼���
	public ArrayList<HashMap<String, Object>> selectCategory() throws Exception{
		
		// Lib���� Ŭ���� jar �ε�
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//���� ���� - ī�װ��� / ���� 10�� / ���� 10�� 
		String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		
		PreparedStatement cagetoryStmt = conn.prepareStatement(categorySql);
		
		ResultSet categoryRs = cagetoryStmt.executeQuery();
		
		//�⺻ ī�װ��� ��̸���Ʈ
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		while(categoryRs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", categoryRs.getString("categoryName"));
			map.put("cnt", categoryRs.getInt("cnt"));
			categoryList.add(map);
		}
		
		return categoryList;
	}
	
	//����Ʈ������ ����Ʈ
	public ArrayList<HashMap<String, Object>> selectBoardListByPage(String categoryName, int currentPage, int rowPerPage) throws Exception {
		
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// ���� ������ ���� �ؽø��� ��̸���Ʈ
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// Lib���� Ŭ���� jar �ε�
		Class.forName("org.mariadb.jdbc.Driver");
		//Ŀ�ؼ� > ���� ����
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// ��񿬰�
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//���� ���� - ī�װ��� / ���� 10�� / ���� 10�� 
		String categoryLimit = "SELECT board_no, category_name, board_title, create_date FROM board WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		String categoryLimitNull = "SELECT board_no, category_name, board_title, create_date FROM board ORDER BY create_date DESC LIMIT ?, ?";
		// LIMIT 1 , 2�� 1> ��𼭺��� �����Ұ���,  2> �����ѵ����� ��� ǥ���Ұ���
		// Limit > ī�װ��� ���� ���� sql �б����
		PreparedStatement stmtLimit = null;
		
		//�б� , false�ϰ�� > null�� ���� true�ϰ�� > ī�װ� : ���� �� ����
		if(categoryName.equals("")) {
			stmtLimit = conn.prepareStatement(categoryLimitNull);
			stmtLimit.setInt(1, beginRow);
			stmtLimit.setInt(2, rowPerPage);
		} else {
			stmtLimit = conn.prepareStatement(categoryLimit);
			stmtLimit.setString(1, categoryName);
			stmtLimit.setInt(2, beginRow);
			stmtLimit.setInt(3, rowPerPage);
		}
		
		// LIMIT RS�� �б��� �ʿ� ����
		ResultSet categoryLimitRs = stmtLimit.executeQuery();
		
		HashMap<String, Object> hash = null;
		
		// �ؽø� data > ����Ʈ��̿� ��´�
		while(categoryLimitRs.next()) {
			hash = new HashMap<String, Object>();
			hash.put("board_no", categoryLimitRs.getInt("board_no"));
			hash.put("category_name", categoryLimitRs.getString("category_name"));
			hash.put("board_title", categoryLimitRs.getString("board_title"));
			hash.put("create_date", categoryLimitRs.getString("create_date"));
			
			list.add(hash);
		}
		
		return list;
	}
	
	//���� �޼���
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		//��û�� ó��
		Board board = new Board();
		board.boardNo = boardNo;
		board.boardPw = boardPw;
		//db�� ����
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser ="root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--DBĿ�ؼ�"); // db�� �� ���� �Ǿ����� �����
		
		//���� �ۼ�
		String deleteSql = "delete from board where board_no = ? and board_pw = ?";
		//���� �Է�
		PreparedStatement stmt = conn.prepareStatement(deleteSql);
		stmt.setInt(1, board.boardNo);
		stmt.setString(2, board.boardPw);
		
		//�����
		int row = stmt.executeUpdate();
		conn.close(); // Ŀ�ؼ� ��ü ��� ��, �ݳ�
		
		return row;
	}
	// �μ�Ʈ
	public int insertBoard(Board bd) throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		String sql = " INSERT INTO board( category_name,board_title,board_content, board_pw, create_date, update_date ) VALUES (  ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, bd.categoryName);
		stmt.setString(2, bd.boardTitle);
		stmt.setString(3, bd.boardContent);
		stmt.setString(4, bd.boardPw);
		ResultSet rs = stmt.executeQuery();

		int row = stmt.executeUpdate(); // ������ �Է��ߴ��� return
		
		return row;
	}
	
	public int updateBoard(Board bd) throws Exception {
		// jar �ε� > db����
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		

		String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = NOW() WHERE board_no = ? AND board_pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, bd.categoryName);
		stmt.setString(2, bd.boardTitle);
		stmt.setString(3, bd.boardContent);
		stmt.setInt(4, bd.boardNo);
		stmt.setString(5, bd.boardPw);
		ResultSet rs = stmt.executeQuery();

		int row = stmt.executeUpdate(); // ������ �Է��ߴ��� return
		
		return row;
	}
} 
