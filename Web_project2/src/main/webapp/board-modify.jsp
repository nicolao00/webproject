<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
	<%
	int ref;
	String passwd = "", sql, sql1;
	String name, e_mail, title, content, reply;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	ref = Integer.parseInt(request.getParameter("ref"));
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

	<h2>게시글 수정</h2>
	<form action="board-modify-db.jsp?ref=<%=ref%>" method="post">
		<table border="0">
			<tr>
				<td width="100">글 제 목:</td>
				<td><input type="text" name="title"
					style="width: 1025px; height: 40px;" pattern=".{1,}"maxlength="40" /></td>
			</tr>
			<tr>
				<td width="100">글 내 용:</td>
				<td><textarea name="content" rows="30" cols="150"
						maxlength="500"></textarea></td>
			</tr>
		</table>
		<br> <input type="submit" value="등록하기" /> <input type="reset"
			value="다시쓰기" />
	</form>
	<img src="image/green_tree.gif">
	<a href="board-list.jsp"> 취소</a>
	<%
	stmt.close();
	conn.close();
	%>
</body>
</html>