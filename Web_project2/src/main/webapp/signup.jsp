<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<meta charset="UTF-8">
<title>sign up</title>
<style>
.new {
	width: 550px;
	height: 40px;
}

.new2 {
	width: 270px;
	height: 40px;
}

.new3 {
	width: 180px;
	height: 40px;
}

.newpwd {
	width: 550px;
	height: 40px;
}

.button {
	background-color: #00008C;
	color: white;
	width: 250px;
	height: 50px;
	border: 0;
}

.check {
	background-color: #00008C;
	color: white;
	width: 130px;
	height: 40px;
	border: 0;
}
</style>
</head>
<body>
	<h1>회원가입</h1>
	<div>가입을 통해 더 많은 레시피를 만나보세요!</div>
	<center>
		<form action="signup-db.jsp" method="post">
			<input type="text" name="name" placeholder="닉네임 입력" class="new"
				pattern=".{1,}"maxlength="10" /> <br> <br> <input type="text" name="id"
				placeholder="아이디 입력 (6~20자)" class="new" pattern=".{6,}"maxlength="20" /> <br>
			<br> <input type="text" name="passwd"
				placeholder="비밀번호 입력(문자,숫자,특수문자 포함 8~20자)" class="newpwd"
				pattern=".{8,}"maxlength="20" /><br> <br> <input type="text"
				name="e_mail" placeholder="이메일 주소" class="new2" />@ <input
				type="text" name="e_mail2" placeholder="이메일 주소" class="new2" /><br>
			<br> <input type="text" name="year" placeholder="년도"
				class="new3" pattern=".{4,}"maxlength="4" /> <input type="text" name="month"
				placeholder="월" class="new3" pattern=".{1,}"maxlength="2" /> <input type="text"
				name="date" placeholder="일" class="new3" pattern=".{1,}"maxlength="2"/><br>
			<br> <input type="submit" class="button" value="가입하기" /> <br>
			<br>
		</form>
	</center>
</body>
</html>