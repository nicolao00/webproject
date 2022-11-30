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
	String name, e_mail, title, content, reply;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ref = Integer.parseInt(request.getParameter("ref"));

	title = request.getParameter("title");
	content = request.getParameter("content");

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		sql = "select * from board where ref=" + ref;
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	%>
	<%
	sql1 = "update board set title='" + title + "', content='" + content + "' where ref = " + ref;
	try {
		stmt.executeUpdate(sql1);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	%>
	<center>
		<h2>게시글이 수정되었습니다</h2>
		<a href="board-read.jsp?ref=
			<%=ref%>">작성한 글 확인</a> <a
			href="board-list.jsp"> 게시글 목록 보기</a>
	</center>
	<%
	stmt.close();
	conn.close();
	%>
</body>
</html>