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
<meta charset="utf-8">
<link rel="stylesheet" href="recipepage.css">
</head>
<body>
	<%
	int pagenum = 1;
	if (request.getParameter("page") != null) {
		pagenum = Integer.parseInt(request.getParameter("page"));
	}
	int fpage = pagenum * 8, bpage = (pagenum - 1) * 8;
	int ref;
	String id;
	String name = getCookieValue(cookies, "NAME");
	int rownum = 0;
	Connection conn = null;
	Statement stmt = null;
	String sql = null, sql2 = null;
	ResultSet rs = null;
	String name2 = null;
	String search = "";
	if (request.getParameter("search") != null)
		search = request.getParameter("search");
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		sql = "select * from recipe where tag like '%" + search + "%'order by id desc limit " + fpage + " offset " + bpage;
		sql2 = "select * from recipe where tag like '%" + search + "%' order by id desc limit";
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동	오류입니다. : " + e.getMessage());
	}
	rs.last();
	rownum = rs.getRow();
	rs.beforeFirst();
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
	<div>
		<table class="category">
			<tr>
				<th class="name">카테고리</th>
				<td><a href="recipepage-search.jsp?search=한식">한식</a> <a
					href="recipepage-search.jsp?search=중식">중식</a> <a
					href="recipepage-search.jsp?search=일식">일식</a> <a
					href="recipepage-search.jsp?search=양식">양식</a></td>
			</tr>
			<tr>
				<th class="name">요리목적</th>
				<td><a href="recipepage-search.jsp?search=아침">아침</a> <a
					href="recipepage-search.jsp?search=점심">점심</a> <a
					href="recipepage-search.jsp?search=저녁">저녁</a> <a
					href="recipepage-search.jsp?search=야식">야식</a> <a
					href="recipepage-search.jsp?search=간식">간식</a> <a
					href="recipepage-search.jsp?search=술안주">술안주</a> <a
					href="recipepage-search.jsp?search=다이어트">다이어트</a> <a
					href="recipepage-search.jsp?search=벌크업">벌크업</a> <a
					href="recipepage-search.jsp?search=비건">비건</a></td>

			</tr>
			<tr>
				<form action="recipepage-search.jsp"
					method="post">
				<th class="name">요리재료</th>
				<td><a href="recipepage-search.jsp?search=돼지고기">돼지고기</a> <a
					href="recipepage-search.jsp?search=닭고기">닭고기</a> <a
					href="recipepage-search.jsp?search=소고기">소고기</a> <a
					href="recipepage-search.jsp?search=생선">생선</a> <a
					href="recipepage-search.jsp?search=해산문">해산물</a> <a
					href="recipepage-search.jsp?search=쌀">쌀</a> <a
					href="recipepage-search.jsp?search=밀가루">밀가루</a> <a
					href="recipepage-search.jsp?search=채소류">채소류</a> 검색:<input
					type="text" name="search"
					onKeypress="javascript:if(event.keyCode==13) {search_onclick_submit}">
					</form></td>
			</tr>
		</table>
	</div>
	<br>
	<div class="semitag">
		<form action="" method="">
			<table>
				<tr>
					<td class="menutag"><a>한식, 양식 &gt 점심, 저녁 &gt 돼지고기, 닭고기,
							해산물</a></td>
					<td><select>
							<option value='head' selected>최신순</option>
							<option value='writer'>인기순</option>
					</select></td>
				</tr>
			</table>
		</form>
	</div>
	<br>
	<div class="menulist">
		<%
		String image;
		int cnt = 0;
		%>
		<table cellspacing="45" cellpadding="10" class="foods">
			<tr>
				<%
				while (rs.next()) {
					image = rs.getString("image");
					if (cnt % 4 == 0 && cnt != 0) {
				%>
			</tr>
			<tr>
				<%
				}
				%>
				<td><a href="#"><%=cnt%><%=rs.getString("menu_name")%><br>
						<img src="recipefolder/<%=image%>" class="food"></a>
					<div class="info">
						조회수:<%=Integer.parseInt(rs.getString("view"))%>
						<button>
							&#9829
							<%=Integer.parseInt(rs.getString("view"))%></button>
					</div></td>
				<%
				cnt++;
				}
				%>
			</tr>
		</table>
		<%
		if (name != null) {
		%>
		<a href="makerecipe.jsp">글쓰기</a>
		<%
		}
		%>
	</div>
	<br>
	<center>
		<%
		sql2 = "select * from recipe where tag like '%" + search + "%'";
		rs = stmt.executeQuery(sql2);
		rs.last();
		rownum = rs.getRow();
		for (int i = 1; i <= rownum / 9 + 1; i++) {
		%>
		<a href="recipepage.jsp?page=<%=i%>" class="num selected"> <%
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
	</center>
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