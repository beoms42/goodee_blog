<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	request.setCharacterEncoding("utf-8");

	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	
	// 업데이트를 해보자
	Guestbook gb = new Guestbook();
	GuestbookDao gbD = new GuestbookDao();
	
	gb.guestbookNo = guestbookNo;
	gb.guestbookContent = guestbookContent;
	gb.guestbookPw = guestbookPw;
	
	int row = gbD.updateGuestbook(gb);
	
	System.out.println(row +"==========row===========");
	
	// row를 반환받는다.
	if(row == 0) {
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo="+gb.guestbookNo); // 실패시 다시입력해야함
	} else if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 성공하면 리스트로.
	} else {	
		
	}
	
	
%>