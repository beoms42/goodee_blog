<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "java.util.ArrayList" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();
	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0 -> 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	
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
	 <jsp:include page="/inc/upMenu.jsp"></jsp:include>
	</div>

	
	<div class="row">
	
	  <div class="container col-sm-1">
	  </div>
	  <div class="container col-sm-1">
		 
	  </div>
	  <div class="container col-sm-1">
	  </div>
	  
	  <div class="col-sm-5 container">
	  	
			  	<% 
					for(Guestbook g : list) {
				%>
				<table class="table table-striped">
					<tr>
						<td><%=g.writer%></td>
						<td><%=g.createDate%></td>
					</tr>
					<tr>
						<td colspan="2"><%=g.guestbookContent%></td>
					</tr>
					<tr>
						<td colspan="2"><a href="updateGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">[수정]</a><a href="deleteGuestbookForm.jsp?guestbookNo=<%=g.guestbookNo%>">[삭제]</a></td>
					</tr>
				</table>
			<%	
				}
				
				if(currentPage > 1) {
			%>
					<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%		
				}
				
				if(currentPage < lastPage) {
			%>
					<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>
	
			<!-- 방명록 입력 -->
			<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp">
				<table class="table table-striped">
					<tr>
						<td>글쓴이</td>
						<td><input type="text" name="writer"></td>
						<td>비밀번호</td>
						<td><input type="password" name="guestbookPw"></td>
					</tr>
					<tr>
						<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60"></textarea></td>
					</tr>
				</table>
				<button type="submit">입력</button>
			</form>
	
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
</body>
</html>