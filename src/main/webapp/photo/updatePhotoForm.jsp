<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//list로부터
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	// DAO
	PhotoDao pd = new PhotoDao();

	Photo ph = pd.selectPhotoOne(photoNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="jumbotron text-center">
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
		
		<form action="<%=request.getContextPath()%>/photo/updatePhotoAction.jsp" method="post">
					<table class="table table-striped">
						<tr>
							<td>photoNo</td>
							<td><input type="text" name="photoNo" value="<%=ph.photoNo%>" readonly="readonly"></td>
						</tr>
						
						<tr>
							<td>photoName</td>
							<td><input type="text" name="photoName" value = "<%=ph.photoName%>"></td>
						</tr>
						
						<tr>
							<td>writer</td>
							<td><input type="text" name="writer" value = "<%=ph.writer%>"></td>
						</tr>
						<tr>
							<td>password</td>
							<td><input type="password" name="photoPw" ></td>
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