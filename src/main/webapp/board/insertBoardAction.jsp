<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "dao.BoardDao" %>
<%@ page import = "vo.Board" %>
<%

	request.setCharacterEncoding("utf-8");	
	
	String categoryNameGet = request.getParameter("categoryName");
	String boardTitleGet = request.getParameter("boardTitle");
	String boardContentGet = request.getParameter("boardContent");
	String boardPwGet = request.getParameter("boardPw");
	
	Board bd = new Board();
	bd.categoryName = categoryNameGet;
	bd.boardTitle = boardTitleGet;
	bd.boardContent = boardContentGet;
	bd.boardPw = boardPwGet;
	
	BoardDao bDao= new BoardDao();
	int row = bDao.insertBoard(bd);
	// 디버깅
	if(row == 1) {
		System.out.println(row+"행 입력성공");
	} else {
		System.out.println("입력실패");
	}

   response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>