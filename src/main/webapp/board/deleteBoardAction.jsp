<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import ="vo.*" %>
<%@ page import = "dao.BoardDao" %>

<%
	//널체크
	if(request.getParameter("boardNo")==null){ // boardNo가 없으면 리스트로 보냄
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
	return;
	}

	//요청값 받기
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); //boardNo을 변수에 저장
	String boardPw = request.getParameter("boardPw"); //boardPw 저장
	System.out.println(boardNo+"<--boardNo");//디버깅
	System.out.println(boardPw+"<--boardPw");//디버깅
	
	BoardDao bd = new BoardDao();
	
	int row = bd.deleteBoard(boardNo, boardPw);
	
	if(row == 0){//삭제 실패
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp?boardNo="+boardNo); // 실패하면 delteboardform으로 비밀번호와 함께 돌려보냄
		System.out.println("삭제실패");
	//비밀번호가 틀렸습니다. 메세지 출력
	}else if(row == 1){ //삭제 성공
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp"); // 성공하면 list로 보냄
		System.out.println("삭제성공");
	}
%>