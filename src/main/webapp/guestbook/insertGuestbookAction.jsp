<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	request.setCharacterEncoding("utf-8");
	
	// vo
	Guestbook guestbook = new Guestbook();
	guestbook.writer  = request.getParameter("writer");
	guestbook.guestbookPw = request.getParameter("guestbookPw");
	guestbook.guestbookContent = request.getParameter("guestbookContent");
	
	// dao
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook);

	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
%>  