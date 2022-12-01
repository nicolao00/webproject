<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<title>main page</title>
<link rel="stylesheet" href="notice-insert.css">
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
	<div class="notice">
		공지사항 > 글쓰기
		<button type="button" name="list"
			onclick="location.href='notice-list.jsp'">목록</button>
	</div>
	<br>
	<div class="writing-page">
		<form action="notice-insert-db.jsp" method="post">
			<table cellspacing="20">
				<tr>
					<td>제목:</td>
					<td class="head"><input type="text" name="title"
						pattern=".{1,}" maxlength="40"></td>
				</tr>
				<tr>
					<td>내용:</td>
					<td class="content"><input type="text" name="content"
						maxlength="500"></td>
				</tr>
			</table>
			<div class="buttons">
				<table>
					<tr>
						<td><input type="submit" value="등록하기"></td>
						<td><input type="reset" value="다시쓰기"></td>
					</tr>
				</table>
		</form>
	</div>
	</div>