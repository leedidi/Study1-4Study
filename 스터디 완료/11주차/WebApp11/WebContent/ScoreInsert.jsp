<%@page import="com.test.ScoreDTO"%>
<%@page import="com.test.ScoreDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%-- 
<%
	// 이전 페이지로부터 데이터 수신
	//-- 데이터 입력 액션 처리 페이지
	
	request.setCharacterEncoding("UTF-8");
	
//	String uName = request.getParameter("userName");
//	String uKor = request.getParameter("scoreKor");
//	String uEng = request.getParameter("scoreEng");
//	String uMat = request.getParameter("scoreMat");
	
	String uName = request.getParameter("userName");
	int uKor = Integer.parseInt(request.getParameter("scoreKor"));
	int uEng = Integer.parseInt(request.getParameter("scoreEng"));
	int uMat = Integer.parseInt(request.getParameter("scoreMat"));
	
	ScoreDAO dao = null;
	
	int result = 0;
	try
	{
		dao = new ScoreDAO();
		
		ScoreDTO score = new ScoreDTO();
		score.setName(uName);
		score.setScoreKor(uKor);
		score.setScoreEng(uEng);
		score.setScoreMat(uMat);
		
		result = dao.add(score);
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
	dao.close();
		}
		catch(Exception e)
		{
	System.out.println(e.toString());
		}
	}
	
	response.sendRedirect("ScoreList_1.jsp");
%> --%>
<%
	//ScoreInsert.jsp
	
	request.setCharacterEncoding("UTF-8");
	

	String userName = request.getParameter("userName");
	int userKor = Integer.parseInt(request.getParameter("scoreKor"));
	int userEng = Integer.parseInt(request.getParameter("scoreEng"));
	int userMat = Integer.parseInt(request.getParameter("scoreMat"));
	
	ScoreDAO dao = null;
	
	try
	{
		dao = new ScoreDAO();
		
		ScoreDTO score = new ScoreDTO();
		score.setName(userName);
		score.setScoreKor(userKor);
		score.setScoreEng(userEng);
		score.setScoreMat(userMat);
		
		dao.add(score);
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
		try
		{
			dao.close();
		}
		catch(Exception e) 
		{
			System.out.println(e.toString());	
		}
		
	response.sendRedirect("ScoreList.jsp");
	

%>