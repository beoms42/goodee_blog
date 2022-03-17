<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//Form·ÎºÎÅÍ
	int photoNo = Integer.parseInt(request.getParameter("photoNo"));	
	String photoPw = request.getParameter("photoPw");
	String photoName = request.getParameter("photoName");
	String writer = request.getParameter("writer");
	
	
	// DAO
	PhotoDao pd = new PhotoDao();
	
	
%>