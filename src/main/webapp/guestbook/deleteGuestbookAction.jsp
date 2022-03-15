<%@page import="javax.websocket.SendResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>

<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	
	// vo
	Guestbook gb = new Guestbook();
	
	gb.guestbookNo = guestbookNo;
	gb.guestbookPw = guestbookPw;
	
	// dao
	
	GuestbookDao gbD = new GuestbookDao();
	int row = gbD.deleteGuestbook(gb.guestbookNo, gb.guestbookPw);
	
	// row를 반환받는다.
	if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/guestbook/deleteGuestbookForm.jsp?boardNo="+gb.guestbookNo); // 실패시 다시입력해야함
	} else if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 성공하면 리스트로.
	} else {	
		
	}


%>