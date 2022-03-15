package dao;
import java.util.ArrayList;
import vo.Guestbook;
import java.sql.*;

public class GuestbookDao {
	// �깮�꽦�옄 硫붿꽌�뱶
	public GuestbookDao() {}
	
	// �엯�젰
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(guestbook); �샇異�
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/homework";
		String dbuser = "root";
		String dbpw = "java1234";
		/* INSERT INTO guestbook(
		 	guestbook_content, writer, guestbook_pw, create_date, update_date
		 ) VALUES(?,?,?,NOW(),NOW()) */
		String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?,?,?,NOW(),NOW())\r\n";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.guestbookContent);
		stmt.setString(2, guestbook.writer);
		stmt.setString(3, guestbook.guestbookPw);
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("�엯�젰�꽦怨�");
		} else {
			System.out.println("�엯�젰�떎�뙣");
		}
		stmt.close();
		conn.close();
	}
	
   // updateGuestbookAction.jsp�뿉�꽌 �샇異�
   // �씠由� - uddateGuestbook
   // 諛섑솚���엯 - �닔�젙�븳 �뻾�쓽 �닔 諛섑솚 -> 0�닔�젙�떎�뙣, 1�닔�젙�꽦怨� -> int
   // �엯�젰留ㅺ컻蹂��닔 - guestbookNo, guestbookContent, guestbookPw 3媛� -> �븯�굹�쓽 ���엯 留ㅺ컻蹂��닔濡� 諛쏄퀬 �떢�떎 -> Guestbook ���엯�쓣 �궗�슜
   public int updateGuestbook(Guestbook guestbook) throws Exception {
      int row = 0;
      Class.forName("org.mariadb.jdbc.Driver");
      Connection conn = null;
      PreparedStatement stmt = null;
      
      String dburl = "jdbc:mariadb://localhost:3306/homework";
      String dbuser = "root";
      String dbpw = "java1234";
      conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
      
      String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
      stmt = conn.prepareStatement(sql);
      stmt.setString(1, guestbook.guestbookContent);
      stmt.setInt(2, guestbook.guestbookNo);
      stmt.setString(3, guestbook.guestbookPw);
      System.out.println(stmt+" <-- sql updateGuestbook"); 
      row = stmt.executeUpdate();
      
      stmt.close();
      conn.close();
      
      return row;
   }
   
	// �궘�젣
	// 諛섑솚媛� - int > row濡� 由ы꽩�븷�닔�룄�엳�쑝�땲源�
	// �븘�슂媛� - NO, PW
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception
	{
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    String dburl = "jdbc:mariadb://localhost:3306/homework";
	    String dbuser = "root";
	    String dbpw = "java1234";
	    conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
	    String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println(stmt+" <-- sql deleteGuestbook"); 
		row = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook �쟾泥� �뻾�쓽 �닔瑜� 諛섑솚 硫붿꽌�뱶
	public int selectGuestbookTotalRow() throws Exception {
		int row = 0;
		Class.forName("org.mariadb.jdbc.Driver");
		// �뜲�씠�꽣踰좎씠�뒪 �옄�썝 以�鍮�
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/homework";
		String dbuser = "root";
		String dbpw = "java1234";
		
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}
	
	// guestbook �븯�굹留� ���젆�빐�꽌 諛쏆쓣嫄� < Guestbook�쓣 諛섑솚
		public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
			
			Class.forName("org.mariadb.jdbc.Driver");
			// �뜲�씠�꽣踰좎씠�뒪 �옄�썝 以�鍮�
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			Guestbook g = new Guestbook();
			
			String dburl = "jdbc:mariadb://localhost:3306/homework";
			String dbuser = "root";
			String dbpw = "java1234";
			
			String sql = "SELECT * FROM guestbook where guestbook_No = ?";
			conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, guestbookNo);
			rs = stmt.executeQuery(); 
			
			//�뼱�뵒�뿉 �벝吏� 紐⑤Ⅴ�땲 �떎�꽔�뼱蹂댁옄
			if(rs.next()) {
				g.guestbookNo = rs.getInt("guestbook_No");
				g.guestbookPw = rs.getString("guestbook_Pw");
				g.createDate = rs.getString("create_Date");
				g.guestbookContent = rs.getString("guestbook_Content");
				g.writer = rs.getString("writer");
				g.updateDate = rs.getString("update_Date");
			}
			
			return g;
		}
	
	
	// guestbook n�뻾�뵫 諛섑솚 硫붿꽌�뱶
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		// guestbook 10�뻾 諛섑솚�릺�룄濡� 援ы쁽
		Class.forName("org.mariadb.jdbc.Driver");
		
		// �뜲�씠�꽣踰좎씠�뒪 �옄�썝 以�鍮�
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/homework";
		String dbuser = "root";
		String dbpw = "java1234";
		/*
		 SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate 
		 FROM guestbook 
		 ORDER BY create_date 
		 DESC LIMIT ?, ?
		 */
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate FROM guestbook ORDER BY create_date DESC LIMIT ?, ?";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// �뜲�씠�꽣踰좎씠�뒪 濡쒖쭅 �걹
		
		// �뜲�씠�꽣 蹂��솚(媛�怨�)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.guestbookNo = rs.getInt("guestbookNo");
			g.guestbookContent = rs.getString("guestbookContent");
			g.writer = rs.getString("writer");
			g.createDate = rs.getString("createDate");
			list.add(g);
		}
		
		// �뜲�씠�꽣踰좎씠�뒪 �옄�썝�뱾 諛섑솚
		rs.close();
		stmt.close();
		conn.close();
	
		return list;
	}
}