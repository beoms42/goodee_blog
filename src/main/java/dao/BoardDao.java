package dao;

import java.util.ArrayList;
import java.util.HashMap;


import vo.Board;
import java.sql.*;

public class BoardDao {
	public BoardDao() {}
	
	//카테고리 보기 메서드
	public ArrayList<HashMap<String, Object>> selectCategory() throws Exception{
		
		// Lib밑의 클래스 jar 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//쿼리 연결 - 카테고리용 / 선택 10개 / 비선택 10개 
		String categorySql = "SELECT category_name categoryName, COUNT(*) cnt FROM board GROUP BY category_name";
		
		PreparedStatement cagetoryStmt = conn.prepareStatement(categorySql);
		
		ResultSet categoryRs = cagetoryStmt.executeQuery();
		
		//기본 카테고리의 어레이리스트
		ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
		while(categoryRs.next()) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("categoryName", categoryRs.getString("categoryName"));
			map.put("cnt", categoryRs.getInt("cnt"));
			categoryList.add(map);
		}
		
		return categoryList;
	}
	
	//리스트페이지 셀렉트
	public ArrayList<HashMap<String, Object>> selectBoardListByPage(String categoryName, int currentPage, int rowPerPage) throws Exception {
		
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 개별 정보를 담을 해시맵의 어레이리스트
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		// Lib밑의 클래스 jar 로딩
		Class.forName("org.mariadb.jdbc.Driver");
		//커넥션 > 디비로 연결
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		// 디비연결
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);

		//쿼리 연결 - 카테고리용 / 선택 10개 / 비선택 10개 
		String categoryLimit = "SELECT board_no, category_name, board_title, create_date FROM board WHERE category_name=? ORDER BY create_date DESC LIMIT ?, ?";
		String categoryLimitNull = "SELECT board_no, category_name, board_title, create_date FROM board ORDER BY create_date DESC LIMIT ?, ?";
		// LIMIT 1 , 2는 1> 어디서부터 시작할건지,  2> 시작한데부터 몇개를 표시할건지
		// Limit > 카테고리의 선택 비선택 sql 분기실행
		PreparedStatement stmtLimit = null;
		
		//분기 , false일경우 > null값 실행 true일경우 > 카테고리 : 여행 등 실행
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
		
		// LIMIT RS는 분기할 필요 없음
		ResultSet categoryLimitRs = stmtLimit.executeQuery();
		
		HashMap<String, Object> hash = null;
		
		// 해시맵 data > 리스트어레이에 담는다
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
	
	//삭제 메서드
	public int deleteBoard(int boardNo, String boardPw) throws Exception {
		//요청값 처리
		Board board = new Board();
		board.boardNo = boardNo;
		board.boardPw = boardPw;
		//db와 연결
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser ="root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl,dbuser,dbpw);
		System.out.println(conn+"<--DB커넥션"); // db와 잘 연결 되었는지 디버깅
		
		//쿼리 작성
		String deleteSql = "delete from board where board_no = ? and board_pw = ?";
		//쿼리 입력
		PreparedStatement stmt = conn.prepareStatement(deleteSql);
		stmt.setInt(1, board.boardNo);
		stmt.setString(2, board.boardPw);
		
		//디버깅
		int row = stmt.executeUpdate();
		conn.close(); // 커넥션 객체 사용 끝, 반납
		
		return row;
	}
	// 인서트
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

		int row = stmt.executeUpdate(); // 몇행을 입력했는지 return
		
		return row;
	}
	
	public int updateBoard(Board bd) throws Exception {
		// jar 로딩 > db연결
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

		int row = stmt.executeUpdate(); // 몇행을 입력했는지 return
		
		return row;
	}
} 
