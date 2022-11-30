<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
Cookie[] cookies = request.getCookies();
%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
	Cookie cookie = new Cookie("ID", "");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	cookie = new Cookie("E_MAIL", "");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	cookie = new Cookie("NAME", "");
	cookie.setMaxAge(0);
	response.addCookie(cookie);
	if(session!=null)
		session.invalidate();
	response.sendRedirect("mainpage.jsp");

	%>
</body>
</html>
