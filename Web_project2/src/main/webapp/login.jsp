<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
a {
	color: blue;
}

.button {
	background-color: #32BEBE;
	border-radius: 5px;
	color: white;
	width: 250px;
	height: 50px;
	border: 0;
}

.in {
	width: 450px;
	height: 40px;
}
</style>
</head>
<body>
	<h1>Sign in</h1>
	<a href="signup.jsp">or create an account</a>
	<center>
		<form action="login-db.jsp" method="post">
			<input type="text" name="id" placeholder="아이디" class="in" pattern=".{6,}"maxlength="20"/><br>
			<br> <input type="password" name="passwd" placeholder="비밀번호"
				class="in" pattern=".{8,}"maxlength="20"/><br> <br> <input type="submit"
				class="button" value="로그인" /><br> <br>
		</form>
		아이디가 없으신가요?
	</center>
</body>
</html>