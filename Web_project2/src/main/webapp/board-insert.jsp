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

	<h2>게 시 판</h2>
	<form action="board-insert-db.jsp?" method="post">
		<table border="0">
			<tr>
				<td width="100">글 제 목:</td>
				<td><input type="text" name="title"
					style="width: 1025px; height: 40px;" pattern=".{1,}" maxlength="40" /></td>
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
	<a href="board-list.jsp"> 게시글 목록 보기</a>

</body>
</html>
