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
<link rel="stylesheet" href="mainpage.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">
</head>
<body>
	<div>
		<table>
			<br>
			<tr>
				<td class="logo"><a href="#"><img
						src="images/mainimage.png" class="mainimage"> 허브레시피</a></td>
				<td>
					<form action="" method="">
						<fieldset class="search-from">
							<input class="input-text" placeholder="레시피를 검색해주세요." type="text">
							<button id="search-btn" type="submit"
								style="background: none; border: 0px;">
								<img src="images/search_btn.png" class="submit-btn">
							</button>
						</fieldset>
					</form>
				</td>
				<%
				if (getCookieValue(cookies, "NAME") == null) {
				%>
				<td class="page-btn"><a href="login.jsp"><img
						src="images/login_btn.png">로그인</a></td>
				<%
				} else {
				%>
				<td class="page-btn"><a href="logout.jsp"><img
						src="images/login_btn.png">로그아웃</a></td>
				<%
				}
				%>
				<%
				if (getCookieValue(cookies, "NAME") != null) {
				%>
				<td class="page-btn"><a href="mypage.jsp"><img
						src="images/mypage_btn.png">마이페이지</a></td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	<br>
	<br>
	<div>
		<nav>
			<table class="topmenu">
				<tr>
					<th><a href="notice-list.jsp">공지사항</a></th>
					<th><a href="recipepage.jsp">레시피</a></th>
					<th><a href="board-list.jsp">게시판</a></th>
					<th><a href="#">랭킹</a></th>
				</tr>
			</table>
		</nav>
	</div>
	<br>
	<div class="menulist">
		<table>
			<tr>
				<td colspan="2"><br> <span class="ad_1">인기탑</span></td>
			<tr>
		</table>
		<table cellspacing="45" cellpadding="10" class="foods">
			<tr>
				<%
				Connection conn = null;
				Statement stmt = null;
				String sql = null;
				ResultSet rs = null;
				try {
					Class.forName("com.mysql.jdbc.Driver");
					String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
					conn = DriverManager.getConnection(url, "root", "0000");
					stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
					sql = "select * from recipe order by view desc limit " + 4 + " offset " + 0;
					rs = stmt.executeQuery(sql);
				} catch (Exception e) {
					out.println("DB 연동 오류입니다. : " + e.getMessage());
				}
				while (rs.next()) {
				%>
				<td><a href="recipe-read.jsp?id=<%=rs.getString("id")%>"><img src="recipefolder/<%=rs.getString("image") %>" class="food"><br><%=rs.getString("menu_name") %></a></td>
				<%
				}
				%>
			</tr>
		</table>
	</div>
	<br>
	<div class="menulist">
		<table class>
			<tr>
				<td colspan="2"><br> <span class="ad_1">인기급상승</span></td>
			<tr>
		</table>
		<table cellspacing="45" cellpadding="10" class="foods">
			<tr>
				<td><a href="#"><img src="images/menu5.png" class="food"><br>파스타</a></td>
				<td><a href="#"><img src="images/menu6.png" class="food"><br>냉면</a></td>
				<td><a href="#"><img src="images/menu7.png" class="food"><br>콩국수</a></td>
				<td><a href="#"><img src="images/menu8.png" class="food"><br>미역국</a></td>
			</tr>
		</table>
	</div>
	<br>
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