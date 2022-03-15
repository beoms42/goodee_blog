<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>

<%
	// 다시 돌아올때 카테고리 이름 받을 변수
	String categoryNameGet = request.getParameter("categoryName");
	int boardNoGet = Integer.parseInt(request.getParameter("boardNo"));


	Board bd = null;

	
	// Lib밑의 클래스 jar 로딩
	Class.forName("org.mariadb.jdbc.Driver");
	//커넥션 > 디비로 연결
	Connection conn = null;
	String dburl = "jdbc:mariadb://localhost:3306/blog";
	String dbuser = "root";
	String dbpw = "java1234";
	// 디비연결
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);

	//쿼리 연결 - 상세정보보기
	String categoryOne = "select board_no, board_title, board_content, category_name, board_pw, update_date, create_date from board where board_No = ?";
	
	
	//보드원용 자세히보기
	PreparedStatement cagetoryStmtOne = conn.prepareStatement(categoryOne);
	cagetoryStmtOne.setInt(1, boardNoGet);
	

	
	// LIMIT RS는 분기할 필요 없음
	ResultSet categoryOneRs = cagetoryStmtOne.executeQuery();

	
	// 보드원은 하나만 보는거라 어레이리스트가 필요없음
	while(categoryOneRs.next()) {
		bd = new Board();
		bd.boardNo = categoryOneRs.getInt("board_no");
		bd.boardTitle = categoryOneRs.getString("board_title");
		bd.boardContent = categoryOneRs.getString("board_content");
		bd.categoryName = categoryOneRs.getString("category_name");
		bd.boardPw = categoryOneRs.getString("board_pw");
		bd.updateDate = categoryOneRs.getString("update_date");
		bd.createDate = categoryOneRs.getString("create_date");
	}
	

	
	conn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

</head>
<body>
	<div class="jumbotron text-center" style="margin-bottom:0">
		  <h1>My Blog</h1>
		  <p>Use Database</p> 
		</div>
		
	<div class="row">	
		<div class="container col-sm-1">
		 </div>
		 <div class="container col-sm-1">
		 </div>
		 <div class="container col-sm-1">
		 </div>
		  
		  <div class="container col-sm-5 ">
		  <br>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>boardNo</th>
						<td><%=bd.boardNo%></td>
					</tr>
					
					<tr>
						<th>boardTitle</th>
						<td><%=bd.boardTitle%></td>
					</tr>
					
					<tr>
						<th>boardContent</th>
						<td><%=bd.boardContent%></td>
					</tr>
					
					<tr>
						<th>categoryName</th>
						<td><%=bd.categoryName%></td>
					</tr>
					
					<tr>
						<th>updateDate</th>
						<td><%=bd.updateDate%></td>
					</tr>
					<tr>
						<th>createDate</th>
						<td><%=bd.createDate%></td>
					</tr>
					
				</thead>
			</table>
			<A href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%=bd.boardNo%>">[수정]</A>
			<A href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%=bd.boardNo%>">[삭제]</A>
		</div>
		
		<div class="col-sm-4 container">
		</div>
	</div>
</body>
</html>