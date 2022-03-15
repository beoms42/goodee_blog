<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//넘버값 받기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	  		<h1> 삭제하기 </h1>
	<form method="post" action= "deleteGuestbookAction.jsp">
	<table class="table table-striped">
		<tr>
			<td>
			글 번호 :
			</td>
			<td>
			<input type="text" name="guestbookNo" value="<%=guestbookNo %>" readonly="readonly">
			</td>
		</tr>
		
		<tr>
			<td>
			삭제 패스워드 :
			</td>
			<td>
			<input type="password" name="guestbookPw"> 
			</td>
		</tr>
		<tr>
			<td>
			<button type="submit">제출</button>
			</td>
		</tr>
	</table>
	</form>
			
			
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
	
</body>
</html>