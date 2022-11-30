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
	<table>
		<tr>
			<td><h1>
					<a href="mainpage.jsp">허브레시피</a>
				</h1></td>
			<td align="center" width="500"><h2>
					<a href="board-list.jsp">게시글 목록</a>
				</h2></td>
		</tr>
	</table>
	<center>
		<table border="1" align="center">
			<tr>
				<td align="center" bgcolor="silver" width="150" height="40">글번호</td>
				<td align="center" bgcolor="silver" width="1000" height="40">제목</td>
				<td align="center" bgcolor="silver" width="150" height="40">작성자</td>
				<td align="center" bgcolor="silver" width="300" height="40">작성일</td>
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
			String type = request.getParameter("type");
			String search = request.getParameter("search_form");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
				conn = DriverManager.getConnection(url, "root", "0000");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				if (type.equals("head")) {
					sql = "select * from board where title like '%" + search + "%'order by ref desc, id asc limit " + fpage + " offset " + bpage;
				} else if (type.equals("writer")) {
					sql = "select * from board where content like '%" + search + "%'order by ref desc, id asc limit " + fpage + " offset " + bpage;
				} else {
					sql = "select * from board where title like '%" + search + "%'or content like '%" + search + "%'order by ref desc, id asc limit " + fpage + " offset " + bpage;
				}
				rs = stmt.executeQuery(sql);
			} catch (Exception e) {
				out.println("DB 연동 오류입니다. : " + e.getMessage());
			}

			rs.last();
			rownum = rs.getRow();
			rs.beforeFirst();
			int i;
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

		<%
		sql = "select * from board where title like '%" + search + "%'";
		rs = stmt.executeQuery(sql);
		rs.last();
		rownum = rs.getRow();
		for (i = 1; i <= rownum / 11 + 1; i++) {
		%>
		<a
			href="board-search.jsp?page=<%=i%>&type=<%=type%>&search_form=<%=search%>"
			class="num selected">
			<%
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
	</center>
	<br>
	<a href="board-insert.jsp">게시글 쓰기</a>
</body>
</html>