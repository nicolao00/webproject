<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
Cookie[] cookies = request.getCookies();
%>
<html>
<head>
<title>게시판</title>
</head>
<body>
	<h2>
		<a href="mainpage.jsp">허브레시피</a>
	</h2>

	<%
	int ref = 0;
	String id, date = "";
	String name = "", title = "", content = "";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String boardname = getCookieValue(cookies, "NAME");
	ref = Integer.parseInt(request.getParameter("ref"));

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		String sql = "select * from notice where ref=" + ref;
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	if (rs == null)
		out.print("암됨");
	else {
		while (rs.next()) {
			name = rs.getString("name");
			title = rs.getString("title");
			content = rs.getString("content");
			ref = Integer.parseInt(rs.getString("ref"));
			date = rs.getString("date");
		}
	}
	%>
	<table border="0">
		<tr bgcolor="#FFCD28">
			<td width="1800" height="40" colspan="4"><%=title%></td>
		</tr>
		<tr>
			<td height="40" width="100"><img src="image/ball.gif"> 글 쓴
				이:</td>
			<td><%=name%></td>
			<td width="100"><img src="image/ball.gif"> 작성일:</td>
			<td><%=date%></td>
		</tr>
		<tr>
			<td bgcolor="#FFAF00" height="400" colspan="4"><%=content%></td>
		</tr>
	</table>
	<br>
	<br>
	<%
	if (name.equals(boardname)) {
	%>
	<a href="notice-modify.jsp?ref=<%=ref%>">게시글 수정</a>

	<a href="notice-delete-db.jsp?ref=<%=ref%>">게시글 삭제</a>
	<%
	}
	stmt.close();
	conn.close();
	%>
	<a href="notice-list.jsp">게시글 목록 보기</a>
</body>
</html>
<%!private String getCookieValue(Cookie[] cookies, String name) {
		String value = null;
		if (cookies == null)
			return null;
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}%>