<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	String photoPw = request.getParameter("photoPw");
	
	//파일이 삭제될경우 업로드에서도 삭제해야함....	
	//그래서 삭제하기전에 DAO에서 미리 삭제하기전에 DATA를 받아두는거임 그게 해시맵
	HashMap<String, Object> hm = null;
	PhotoDao pd = new PhotoDao(); 
	String path = application.getRealPath("upload"); // application변수 톰켓을 가르키는 변수
	
	//강제 캐스팅이라고 하던데
	hm = pd.deletePhoto(photoNo, photoPw);
	int row = (int)hm.get("row");
	String photoName = (String)hm.get("photoName");
	
	if(row == 1) {
		File file = new File(path+"\\"+photoName); // 잘못된 파일을 불러온다. java.io.File  
		System.out.println(file + "<---------- 삭제");
		file.delete(); // DB에서 삭제된 파일 삭제
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
		
	} else {
		//틀렸을땐 다시 가라
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo="+photoNo);
	}
%>