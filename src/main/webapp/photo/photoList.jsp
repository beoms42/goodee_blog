<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	int beginRow = 0;
	int rowPerPage = 9;

	PhotoDao photoDao = new PhotoDao();
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
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
				<%
					int i = 0;
					for(Photo p : list) {
						i++;
				%>
							<td>
								<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp=photoNo=<%=p.photoNo%>">
									<img src="<%=request.getContextPath()%>/upload/<%=p.photoName%>" width="200">
									<!--  상세보기에서는 원본이미지 크기로 -->
								</a>
							</td>
				<%		
					if(i == 3) {
						%>
						</tr><tr>
						
						<%			
						i = 0;
					}
				}
				%>
				</tr>
			</table>
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
	
	
</body>
</html>