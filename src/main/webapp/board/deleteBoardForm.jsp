<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	//널 체크
	if(request.getParameter("boardNo")==null){ // boardNo가 null일경우 boardList로 돌려보냄
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
		return;
	}

	//요청값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 받기
	System.out.println(boardNo+"<--boardNo");//디버깅
	String msg = " "; //에러 값 받기
	if(request.getParameter("msg") != null){
		msg = "비밀번호가 맞지 않습니다.다시 입력해주세요";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
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
					<form method = "post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
						<table class="table table-striped">
							<tr>
								<td>번호:</td>
								<td><input type = "text" name="boardNo" value ="<%=boardNo%>" readonly = "readonly"></td> <!-- 읽기전용 -->
							</tr>
							
							<tr>
								<td>비밀번호 입력:</td>
								<td><input type = "password" name="boardPw"></td>
							</tr>
						</table>
						<div>
							<button type = "submit">[삭제]</button>
						</div>
					</form>
					<!-- 오류 메세지 출력 -->
					<div><%=msg%></div>
		</div>
		
		<div class="col-sm-4 container">
		</div>
	</div>
	
	
</body>
</html>