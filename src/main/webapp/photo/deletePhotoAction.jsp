<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	String photoPw = request.getParameter("photoPw");
	
	//������ �����ɰ�� ���ε忡���� �����ؾ���....	
	//�׷��� �����ϱ����� DAO���� �̸� �����ϱ����� DATA�� �޾Ƶδ°��� �װ� �ؽø�
	HashMap<String, Object> hm = null;
	PhotoDao pd = new PhotoDao(); 
	String path = application.getRealPath("upload"); // application���� ������ ����Ű�� ����
	
	//���� ĳ�����̶�� �ϴ���
	hm = pd.deletePhoto(photoNo, photoPw);
	int row = (int)hm.get("row");
	String photoName = (String)hm.get("photoName");
	
	if(row == 1) {
		File file = new File(path+"\\"+photoName); // �߸��� ������ �ҷ��´�. java.io.File  
		System.out.println(file + "<---------- ����");
		file.delete(); // DB���� ������ ���� ����
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp");
		
	} else {
		//Ʋ������ �ٽ� ����
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo="+photoNo);
	}
%>