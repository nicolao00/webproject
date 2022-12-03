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
<link rel="stylesheet" href="notice.css">
</head>
<body>
	<div class="contents">
		<table>
			<br>
			<tr>
				<td class="logo"><a href="mainpage.jsp"><img
						src="images/mainimage.png" class="mainimage"> 허브레시피</a></td>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<div class="notice">
		<a href="board-list.jsp">게시판</a>
	</div>
	<br>
	<div class="search">
		<form action="notice-search.jsp" method="post">
			<fieldset class="search-form">
				<select name="type">
					<option value='' selected>전체</option>
					<option value='head'>제목</option>
					<option value='writer'>내용</option>
				</select> <input type="text" name="search_form"
					onKeypress="javascript:if(event.keyCode==13) {search_onclick_submit}" />
			</fieldset>
		</form>
	</div>
	<br>
	<div>
		<table class="mainboard">
			<tr bgcolor="#f3e0ac">
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<%
			int pagenum = 1;
			if (request.getParameter("page") != null) {
				pagenum = Integer.parseInt(request.getParameter("page"));
			}
			int fpage = pagenum * 10, bpage = (pagenum - 1) * 10;
			int ref;
			String id;
			int rownum = 0;
			Connection conn = null;
			Statement stmt = null;
			String sql = null, sql2 = null;
			ResultSet rs = null;
			String name2 = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
				conn = DriverManager.getConnection(url, "root", "0000");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				sql = "select * from board order by ref desc, id asc limit " + fpage + " offset " + bpage;
				sql2 = "select * from board order by ref desc, id asc";
				rs = stmt.executeQuery(sql);
			} catch (Exception e) {
				out.println("DB 연동 오류입니다. : " + e.getMessage());
			}

			rs.last();
			rownum = rs.getRow();
			rs.beforeFirst();
			int i = rownum;
			while (rs.next()) {
				id = rs.getString("id");
				ref = Integer.parseInt(rs.getString("ref"));
			%>
			<tr>
				<td align="center" height="40"><%=rownum%></td>
				<td align="left" height="40"><a
					href="board-read.jsp?ref=<%=rs.getString("ref")%>" width="250">
						<%=rs.getString("title")%></a></td>
				<td align="center" height="40"><%=rs.getString("name")%></td>
				<td align="center" height="40"><%=rs.getString("date")%></td>
			</tr>
			<%
			rownum--;
			}
			%>
		</table>
	</div>
	<br>
	<br>
	<div class="pageButton">
        <%
		sql2 = "select * from board order by ref desc, id asc";
		rs = stmt.executeQuery(sql2);
		rs.last();
		rownum = rs.getRow();
		for (i = 1; i <= rownum / 11 + 1; i++) {
		%>
		<a href="board-list.jsp?page=<%=i%>" class="num selected"> <%
 if (i == pagenum) {
 %><b> <%=i%></b> <%
 } else {
 %> <%=i%> <%
 }
 %>
		</a>
		<%
		;
		}
		%>

		<%
		stmt.close();
		conn.close();
		%>
	</div>
	<br>
	<%
	if (getCookieValue(cookies, "NAME") != null) {
	%>
	<a href="board-insert.jsp">게시글 쓰기</a>
	<%
	}
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