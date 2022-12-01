<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
Cookie[] cookies = request.getCookies();
%>
<html>
<head>
<title>main page</title>
<link rel="stylesheet" href="recipe-read.css">
</head>
<body>
	<%
	int ref = 0, id = 0, view = 0, likes;
	String date = "", ingredient = "", tag = "", image = "", step_explain = "";
	String recipename = "", menu_name = "", content = "", menu_explain = "";
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String name = getCookieValue(cookies, "NAME");
	id = Integer.parseInt(request.getParameter("id"));

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		String sql = "select * from recipe where id=" + id;
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	if (rs != null) {
		rs.next();
		name = rs.getString("name");
		menu_name = rs.getString("menu_name");
		menu_explain = rs.getString("menu_explain");
		step_explain = rs.getString("step_explain");
		date = rs.getString("date");
		ingredient = rs.getString("ingredient");
		tag = rs.getString("tag");
		image = rs.getString("image");
		view = Integer.parseInt(rs.getString("view"));
		view++;
		likes = Integer.parseInt(rs.getString("likes"));
	}
	%>
	<div>
		<table>
			<br>
			<tr>
				<td class="logo"><a href="mainpage.jsp"><img
						src="images/mainimage.png" class="mainimage"> 허브레시피</a></td>
			</tr>
		</table>
	</div>
	<hr>
	<br>
	<div class="content">
		<img src="recipefolder/<%=image%>" class="food">
		<h1><%=name%>님의
			<%=menu_name%></h1>
		<h2><%=menu_explain%></h2>
	</div>
	<br>
	<br>
	<hr>
	<div class="ingredient">
		<h3>재료</h3>
		<p>
			<%
			String sql1 = "update recipe set view=" + view + " where id =" + id;
			try {
				stmt.executeUpdate(sql1);
			} catch (Exception e) {
				out.println("DB 연동 오류입니다. : " + e.getMessage());
			}
			String ingr[] = ingredient.split("&");
			for (int i = 0; i < ingr.length - 1; i++) {
				String pout[] = ingr[i].split("/");
			%>
			<%=pout[0]%>
			:
			<%=pout[1]%><br>
			<%
			}
			%>
		</p>
	</div>
	<br>
	<hr>
	<div class="make">
		<h3>요리 방법</h3>
		<table>
			<%
			String explain[] = step_explain.split("&");
			String sql = "select * from images where id=" + id;
			int cnt = 0;
			rs = stmt.executeQuery(sql);
			while (rs.next() && (cnt < explain.length)) {
				image = rs.getString("image");
			%>
			<tr>
				<td><%=cnt + 1%>.</td>
				<td><img src="recipefolder/<%=image%>" class="food"></td>
				<td><%=explain[cnt]%></td>
			</tr>
			<%
			cnt++;
			}
			%>
		</table>
	</div>
	<br>
	<hr>
	<h3>댓글</h3>
	<div class="reply">
		<hr>
		<table>
			<tr>
				<td class="profile"><br> <img src="images/.png"></td>
				<td><a>김태욱</a></td>
				<td>2022-10-13 22:01</td>
				<td class="contents">너무 맛있어요~</td>
			</tr>
			<tr>
				<td class="profile"><br> <img src="images/.png"></td>
				<td><a>박재형</a></td>
				<td>2022-10-15 22:01</td>
				<td class="contents">만들기 어려워요~</td>
			</tr>
		</table>
		<hr>
	</div>
	<br>
	<form action="" method="">
		<div class="makereply">
			<input type="text" name="write" placeholder="댓글 달기..."></input>
			<button type="submit">등록</button>
		</div>
		<br>
	</form>

	<form action="recipe-modify.jsp?id=<%=id%>" method="post">
		<input type="submit">
	</form>
	<hr>
	<%
	String tags[] = tag.split("#");
	%>
	<div class="hashtag">
		<table>
			<tr>
				<th># 태그</th>
				<%
				for (int i = 0; i < tags.length; i++) {
				%>
				<td><%=tags[i]%></td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	<br>
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