<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.BoardDao" %>
<%
	//인토딩
	request.setCharacterEncoding("utf-8");	
	
	//값을 받음
	int boardNoGet = Integer.parseInt(request.getParameter("boardNo"));
	String categoryNameGet = request.getParameter("categoryName");
	String boardTitleGet = request.getParameter("boardTitle");
	String boardContentGet = request.getParameter("boardContent");
	String boardPwGet = request.getParameter("boardPw");
	
	Board bd = new Board();
	bd.boardNo = boardNoGet;
	bd.categoryName = categoryNameGet;
	bd.boardTitle = boardTitleGet;
	bd.boardContent = boardContentGet;
	bd.boardPw = boardPwGet;
	
	BoardDao bDao = new BoardDao();
	
	int row  = bDao.updateBoard(bd);
	
	// 디버깅, 1행 > 변경성공 else > 실패
	if(row == 1) {
		System.out.println("변경성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else {
		System.out.println("변경실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo="+boardNoGet);
	}

   
%>
