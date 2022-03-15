<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	request.setCharacterEncoding("utf-8");

	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	
	// 하나 셀렉해서 데이터 전부 받아올거
	Guestbook gb = null;
	GuestbookDao gbD = new GuestbookDao();
	
	//selectOne < guestbook 반환.
	// 이렇게 넣어도 되는건가..? 일단 작동하긴 하는데..
	gb = gbD.selectGuestbookOne(guestbookNo);
	
	System.out.println(gb.guestbookPw+"============== 디버깅 pw ============");
	
	
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
	  	<form action="updateGuestbookAction.jsp" method="post">
		<table class="table table-striped">
			<tr>
				<td>
					번호
				</td>
				<td>
					<input type="text" name="guestbookNo" value="<%=gb.guestbookNo %>" readonly="readonly">
				</td>
			</tr>
			
			<tr>
				<td>
					수정할 내용 :
				</td>
				<td>
					<input type="text" name="guestbookContent" value="<%=gb.guestbookContent %>">
				</td>
			</tr>
			
			<tr>
				<td>
					수정하려면 비밀번호를 입력 :
				</td>
				<td>
					<input type="text" name="guestbookPw"">
				</td>
			</tr>
			<tr>
				<td><button type="submit">제출!</button></td>
			</tr>
		</table>
	</form>
			
			
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
	
	

</body>
</html>