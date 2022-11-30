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
	<h1>정보수정</h1>
	<center>
		<form action="my-modify-db.jsp" method="post">
			비밀번호 : <input type="text" name="passwd"
				placeholder="비밀번호 입력(문자,숫자,특수문자 포함 8~20자)" class="newpwd" pattern=".{8,}"maxlength="20"/><br>
			<br> 이메일 : <input type="text" name="e_mail" placeholder="이메일 주소"
				class="new2" />@ <input type="text" name="e_mail2"
				placeholder="이메일 주소" class="new2" /><br> <br> 생년월일 : <input
				type="text" name="year" placeholder="년도" class="new3" pattern=".{4,}"maxlength="4"/> <input
				type="text" name="month" placeholder="월" class="new3" pattern=".{1,}"maxlength="2"/> <input
				type="text" name="date" placeholder="일" class="new3" pattern=".{1,}"maxlength="2"/><br> <br>
			<input type="submit" class="button" value="정보 수정" /> <br> <br>
		</form>
	</center>
</body>
</html>