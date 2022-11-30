<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<body>
	<%
	int ref;
	String passwd = "", sql, sql1;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ref = Integer.parseInt(request.getParameter("ref"));
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		sql = "delete from board where ref=" + ref;
		stmt.executeUpdate(sql);
	%>
	<center>
		<h2>게시글이 삭제되었습니다</h2>
		<a href="board-list.jsp"> 게시글 목록 보기</a>
	</center>
	<%
	} catch (Exception e) {
	out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	stmt.close();
	conn.close();
	%>
</body>
</html>