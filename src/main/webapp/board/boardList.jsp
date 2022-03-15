<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "dao.BoardDao" %>
	<!--  과제
      1) categoryName null 일때 
      SELECT board_no, category_name, board_title, create_date FROM board
      ORDER BY create_date DESC
      LIMIT 0, 10;
      
      2) categoryName null 아닐때
      SELECT board_no, category_name, board_title, create_date FROM board
      WHERE category_name=?
      ORDER BY create_date DESC
      LIMIT 0, 10;
      
      to-do list 0302
      
      1. 먼저 비선택 표시
      2. sql 분기(선택, 비선택)
      3. 선택시 카테고리값 가져옴
      <-- categoryName값 -->
	
<%
	// 다시 돌아올때 카테고리 이름 받을 변수

	String categoryName = "";
	if(request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") !=  null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	
	//dao
	BoardDao bd = new BoardDao();
	// 카테고리를 꺼내보자
	//selectCategory 는 list를 반환 , 입력값 x
	ArrayList<HashMap<String, Object>> categoryList = bd.selectCategory();
	// 실행이 안되네.. 머지?
	System.out.println(categoryList +"<===========categoryList");
	
	//주 게시물 반환, 인자는 3개
	ArrayList<HashMap<String, Object>> list = bd.selectBoardListByPage(categoryName, currentPage, rowPerPage);
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
	 <jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>
	
	
	<div class="row">
	
	  <div class="container col-sm-1">
	  </div>
	  <div class="container col-sm-1">
		  <!--  카테고리별 게시글 볼 수 있도록 link 메뉴 -->
		  <br>
		  <ul class="list-group">
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					<li class="list-group-item ">
						<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
					</li>
			<%		
				}
			%>
		  </ul>
	  </div>
	  <div class="container col-sm-1">
	  </div>
	  
	  <div class="col-sm-5 container">
	  	<table class="table table-striped">
			<thead>
				<tr>
					<th>board_no</th>
					<th>category_name</th>	
					<th>board_title</th>
					<th>create_date</th>
				</tr>
			</thead>
			<tbody>
				<%
				
					for(HashMap h : list) {
				%>
					<tr>
					<td><%=h.get("board_no") %></td>
					<td><%=h.get("category_name") %></td>
					<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=h.get("board_no") %>"><%=h.get("board_title") %></a></td>
					<td><%=h.get("create_date") %></td>
					</tr>
				<%
					}
				%>
				
				
			</tbody>
		  </table>
		  	<% if(currentPage > 1) {%>
			<A href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>">[이전]</A>
			<%}%>
			<A href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&categoryName=<%=categoryName%> ">[다음]</A>
			
			
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
	

</body>
</html>