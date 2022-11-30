<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.util.Date"%>
<%
Cookie[] cookies = request.getCookies();
%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<body>
	<%
	int temp = 0, cnt;
	int new_id = 0;
	String title, content;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql_update;
	Date now = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(now);

	String name = getCookieValue(cookies, "NAME");
	String id = getCookieValue(cookies, "ID");
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		String sql = "select max(ref) as max_ref, count(*) as cnt from notice";
		rs = stmt.executeQuery(sql);

	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}

	while (rs.next()) {
		cnt = Integer.parseInt(rs.getString("cnt"));
		if (cnt != 0)
			new_id = Integer.parseInt(rs.getString("max_ref"));
	}

	new_id++;
	title = request.getParameter("title");
	content = request.getParameter("content");
	if (title.length() > 40 || content.length() > 500) {
	%>
	<center>
		<h2>길이를 지켜주세요</h2>
		<a href="notice-insert.jsp">뒤로</a>
	</center>
	<%
	} else {
	sql_update = "insert into notice values(" + new_id + ",'" + id + "','" + name + "','" + title + "','" + content + "','"
			+ strdate + "')";
	try {
		stmt.executeUpdate(sql_update);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. :" + e.getMessage());
	}
	%>
	<center>
		<h2>작성한 글이 등록되었습니다.</h2>
		<img src="image/green_tree.gif"> <a href="notice-list.jsp">게시글
			목록 보기</a>
	</center>
	<%
	}
	stmt.close();
	conn.close();
	%>
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
