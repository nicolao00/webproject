<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
Cookie[] cookies = request.getCookies();
%>
<html>
<head>
<link href="makerecipe.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<%
int count = 0, c = 0;
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
	String explain[] = step_explain.split("&");
	c = explain.length;
}
%>
<script>
	var count =
<%=c%>
	;

	$(document)
			.ready(
					function() {
						$('#add_ingredient')
								.click(
										function() {
											var tbl = $('<tr><td class="type_name"></td>');
											$(tbl)
													.append(
															'<td class="type_context"><input type="text" name="ingredient" ></td>');
											$(tbl)
													.append(
															'<td class="type_context"><input type="text" name="amount" ></td></tr>');
											$('#ingredient_table').append(tbl);
										});

						$('#add_step')
								.click(
										function() {
											var tbl = $('<tr><td class="type_name"></td>');
											$(tbl)
													.append(
															'<td class="type_context"><textarea name="step_explain"> </textarea></td>');
											$(tbl)
													.append(
															"<td class='type_context'><input type='file' value='사진 추가' name='step_image"
																	+ (count)
																	+ "'accept='image/gif,image/jpeg,image/png'><br><br><input type='file' value='동영상 추가'  accept='video/*'></td></tr>");
											$('#step_table').append(tbl);
											count++;
										});

					});
</script>
</head>

<body>
	<div id="wrap">
		<div id="head">
			<img src="DB에서 새싹 사진 가져와"><a href="mainpage.jsp">허브레시피</a>
		</div>

		<div id="title">레시피 등록</div>

		<div id="main">
			<form action="makerecipe-db.jsp" method="post"
				enctype="multipart/form-data">
				<table name="first">
					<tr>
						<td class="type_name">요리 이름</td>
						<td class="type_context"><input type="text" name="menu_name"
							value="<%=menu_name%>"></td>
					</tr>
					<tr>
						<td>&nbsp</td>
					</tr>
					<tr>
						<td class="type_name">요리 설명</td>
						<td class="type_context"><textarea name="menu_explain"><%=menu_explain%> </textarea></td>
					</tr>
				</table>
				<div id="mainPic">
					<img src="DB에서 레시피 메인사진 가져와"><input type="file" class="file"
						name="mainimage1" value="recipefolder/<%=image%>"
						accept="image/gif,image/jpeg,image/png">
				</div>
				<table id="ingredient_table">
					<%
					/*
							String sql1 = "update recipe set view=" + view + " where id =" + id;
							try {
						stmt.executeUpdate(sql1);
							} catch (Exception e) {
						out.println("DB 연동 오류입니다. : " + e.getMessage());
							}
							*/
					%>
					<tr>
						<td class="type_name">재료 설정</td>
						<td><input type="button" value="재료 추가" id="add_ingredient"></td>
					</tr>
					<%
					String ingr[] = ingredient.split("&");
					for (int i = 0; i < ingr.length - 1; i++) {
						String pout[] = ingr[i].split("/");
					%>
					<tr>
						<td></td>
						<td class="type_context"><input type="text" name="ingredient"
							value="<%=pout[0]%>"></td>
						<td class="type_context"><input type="text" name="amount"
							value="<%=pout[1]%>"></td>
					</tr>
					<%
					}
					%>
				</table>
				<table id="step_table">
					<tr>
						<td class="type_name">상세 설명<br> <br> <input
							type="button" value="단계 추가" id="add_step"></td>
					<tr>
						<%
						String explain[] = step_explain.split("&");
						String sql = "select * from images where id=" + id;
						int cnt = 0;
						rs = stmt.executeQuery(sql);
						while (rs.next() && (cnt < explain.length)) {
							image = rs.getString("image");
						%>
					
					<tr>
						<td></td>
						<td class="type_context"><textarea name="step_explain"> <%=explain[cnt]%></textarea></td>
						<td class="type_context"><input type="file"
							value="recipefolder/<%=image%>" name="step_image<%=cnt%>"
							onchange="setThumbnail(event);"><br> <br> <input
							type="file" value="동영상 추가"
							accept="image/gif,image/jpeg,image/png"></td>
						<%
						cnt++;
						}
						%>
					</tr>
				</table>
				<table>
					<tr>
						<td class="type_name">태그 설정</td>
						<td class="type_context"><input type="text" name="tag"
							id="tag_explain" value="<%=tag%>"></td>
					</tr>
					<tr>
						<td><input type="submit" value="글쓰기" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
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