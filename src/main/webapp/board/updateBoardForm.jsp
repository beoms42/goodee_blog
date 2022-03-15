<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "vo.*" %>

<%
	//인코딩
   request.setCharacterEncoding("utf-8");	
	
    int boardNoGet = Integer.parseInt(request.getParameter("boardNo"));
   
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = null;
   String dburl = "jdbc:mariadb://localhost:3306/blog";
   String dbuser = "root";
   String dbpw = "java1234";
   conn = DriverManager.getConnection(dburl, dbuser, dbpw);
   
   //보드전체값 가져오기
   String getsql = "select board_no, board_title, board_content, category_name, board_pw, update_date, create_date from board where board_No = ?";
   PreparedStatement stmt = conn.prepareStatement(getsql);
   stmt.setInt(1, boardNoGet);
   ResultSet rs = stmt.executeQuery();
   
   Board bd = null;
   

	while(rs.next()) {
		bd = new Board();
		bd.boardNo = rs.getInt("board_no");
		bd.boardTitle = rs.getString("board_title");
		bd.boardContent = rs.getString("board_content");
		bd.categoryName = rs.getString("category_name");
		bd.boardPw = rs.getString("board_pw");
		bd.updateDate = rs.getString("update_date");
		bd.createDate = rs.getString("create_date");
	}
	
	String categorySql = "select category_name from category";
	PreparedStatement categoryStmt = conn.prepareStatement(categorySql);
	ResultSet categoryRs = categoryStmt.executeQuery();
	ArrayList<String> categoryAl = new ArrayList<String>();
	while(categoryRs.next()) {
		String cat = categoryRs.getString("category_name");
		categoryAl.add(cat);
	}
	
	
   conn.close();
%>	


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				<form action="<%=request.getContextPath()%>/board/updateBoardAction.jsp" method="post">
					<table class="table table-striped">
						<tr>
							<td>boardNo</td>
							<td><input type="text" name="boardNo" value="<%=bd.boardNo%>" readonly="readonly"></td>
						</tr>
						
						<tr>
							<td>categoryName</td>
							<td>
							
							<select name ="categoryName">
									<%
										for(String s : categoryAl) {
											if(s.equals(bd.categoryName)) {
									%>
												<option selected="selected" value="<%=s%>" ><%=s%></option>
									<%
											} else {
									%>
												<option value="<%=s%>"><%=s%></option>
									<%		
											}
										}
									%>
							</select>
							
							</td>
						</tr>
						
						<tr>
							<td>boardTitle</td>
							<td><input type="text" name="boardTitle" value = "<%=bd.boardTitle%>"></td>
						</tr>
						
						<tr>
							<td>boardContent</td>
							<td><input type="text" name="boardContent" value = "<%=bd.boardContent%>"></td>
						</tr>
						<tr>
							<td>boardPw</td>
							<td><input type="password" name="boardPw" ></td>
						</tr>
					</table>
					<button type="submit">수정</button>
				</form>
		</div>
		
		<div class="col-sm-4 container">
		</div>
	</div>
	
	
</body>
</html>