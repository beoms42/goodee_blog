<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%
   Class.forName("org.mariadb.jdbc.Driver");
   Connection conn = null;
   String dburl = "jdbc:mariadb://localhost:3306/blog";
   String dbuser = "root";
   String dbpw = "java1234";
   conn = DriverManager.getConnection(dburl, dbuser, dbpw);
   String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
   PreparedStatement stmt = conn.prepareStatement(sql);
   ResultSet rs = stmt.executeQuery();
   ArrayList<String> list = new ArrayList<String>();
   while(rs.next()) {
      list.add(rs.getString("categoryName"));
   }
   conn.close();
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
		  <form method="post" action="<%=request.getContextPath()%>/board/insertBoardAction.jsp">
	      <table class ="table table-striped">
	         <tr>
	            <td>categoryName</td>
	            <td>
	               <select name="categoryName" class="form-select">
	                  <%
	                     for(String s : list) {
	                  %>
	                        <option value="<%=s%>"><%=s%></option>
	                  <%      
	                     }
	                  %>
	               </select>
	            </td>
	         </tr>
	         
	         <tr>	
	         	<td>boardTitle</td>
	         	<td><input name="boardTitle" type="text" class="form-control"></td>
	         </tr>
	         
	         <tr>	
	         	<td>boardContent</td>
	         	<td><input name="boardContent" type="text" class="form-control"></td>
	         </tr>
	         
	         <tr>	
	         	<td>boardPw</td>
	         	<td><input name="boardPw" type="text" class="form-control"></td>
	         </tr>
	         
	         <tr>	
	         	<td colspan = "2"><button type="submit" class="btn">??????</button></td>
	         </tr>
	      </table>
	   	</form>
		</div>
		
		<div class="col-sm-4 container">
		</div>
	</div>

	  
</body>
</html>