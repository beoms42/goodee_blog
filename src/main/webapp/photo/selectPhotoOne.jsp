<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%

	int photoNo = Integer.parseInt(request.getParameter("photoNo"));

	PhotoDao pd = new PhotoDao();

	Photo pdOne = pd.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	  		<br>
			<h1>이미지 목록</h1>
			<table class="table table-striped">
				<tr>
					<td>photo_name</td>
					<td><%=pdOne.photoName %></td>
				</tr>
				<tr>
					<td>photoOriginalName</td>
					<td><%=pdOne.photoOriginalName %></td>
				</tr>
				<tr>
					<td>writer</td>
					<td><%=pdOne.writer %></td>
				</tr>
				<tr>
					<td>photoType</td>
					<td><%=pdOne.photoType %></td>
				</tr>
			</table>
			
			<A href="<%=request.getContextPath()%>/photo/updatePhotoForm.jsp?photoNo=<%=photoNo%>">[수정]</A>
			<A href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%=photoNo%>">[삭제]</A>
			
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
</body>
</html>