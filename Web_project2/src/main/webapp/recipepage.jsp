<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
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
		sql = "select * from recipe order by id desc limit " + fpage + " offset " + bpage;
		sql2 = "select * from recipe order by id desc limit";
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
				<td><a href="#">한식</a> <a href="#">중식</a> <a href="#">일식</a> <a
					href="#">양식</a></td>
			</tr>
			<tr>
				<th class="name">요리목적</th>
				<td><a href="#">아침</a> <a href="#">점심</a> <a href="#">저녁</a> <a
					href="#">야식</a> <a href="#">간식</a> <a href="#">술안주</a> <a href="#">다이어트</a>
					<a href="#">벌크업</a> <a href="#">비건</a></td>

			</tr>
			<tr>
				<form action="" method="">
					<th class="name">요리재료</th>
					<td><a href="#">돼지고기</a> <a href="#">닭고기</a> <a href="#">소고기</a>
						<a href="#">생선</a> <a href="#">해산물</a> <a href="#">쌀</a> <a
						href="#">밀가루</a> <a href="#">채소류</a> 검색:<input type="text"
						name="search"
						onKeypress="javascript:if(event.keyCode==13) {search_onclick_submit}">
				</form>
				</td>
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
							<option value='' selected>정렬</option>
							<option value='head'>최신순</option>
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

	</div>
	<br>
	<%
	sql2 = "select * from recipe order by id desc";
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
</body>
</html>