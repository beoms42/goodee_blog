<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	

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
		<form method = "post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
						<table class="table table-striped">
							<tr>
								<td>번호:</td>
								<td><input type = "text" name="photoNo" value ="<%=photoNo%>" readonly = "readonly"></td> <!-- 읽기전용 -->
							</tr>
							
							<tr>
								<td>비밀번호 입력:</td>
								<td><input type = "password" name="photoPw"></td>
							</tr>
						</table>
						<div>
							<button type = "submit">[삭제]</button>
						</div>
					</form>
	  </div>
	  
	  <div class="col-sm-4 container">
	  </div>
	</div>
</body>
</html>