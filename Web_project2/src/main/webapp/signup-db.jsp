<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
</head>
<body>
	<%
	int year, month, date;
	String id, name, passwd, email;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql_update, sql1 = "";
	boolean flag;
	id = request.getParameter("id");
	name = request.getParameter("name");
	passwd = request.getParameter("passwd");
	email = request.getParameter("e_mail") + "@" + request.getParameter("e_mail2");
	if (id == "" || name == "" || passwd == "" || email == "" || request.getParameter("year") == ""
			|| request.getParameter("month") == "" || request.getParameter("date") == "") {
	%>
	<center>
		<h2>잘못된 입력입니다</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	} else if (id.length() > 20 || name.length() > 10 || passwd.length() > 20 || email.length() > 40) {
	%>
	<center>
		<h2>길이를 지켜주세요</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	} else {
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	date = Integer.parseInt(request.getParameter("date"));
	flag = false;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		String sql = "select * from user";
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다.(1번) : " + e.getMessage());
	}

	while (rs.next()) {
		if (id.equals(rs.getString("id"))) {
			flag = true;
	%>
	<center>
		<h2>중복된 아이디 입니다</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	break;
	} else if (name.equals(rs.getString("name"))) {
	flag = true;
	%>
	<center>
		<h2>중복된 닉네임 입니다</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	break;
	}
	}

	try {
	String sql = "select * from manager";
	rs = stmt.executeQuery(sql);
	} catch (Exception e) {
	out.println("DB 연동 오류입니다.(1번) : " + e.getMessage());
	}

	while (rs.next()) {
	if (id.equals(rs.getString("id"))) {
	flag = true;
	%>
	<center>
		<h2>중복된 아이디 입니다</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	break;
	} else if (name.equals(rs.getString("name"))) {
	flag = true;
	%>
	<center>
		<h2>중복된 닉네임 입니다</h2>
		<a href="signup.jsp">뒤로</a>
	</center>
	<%
	break;
	}
	}

	if (flag == false) {
	sql1 = "insert into user values('" + name + "','" + id + "','" + passwd + "','" + email + "'," + year + "," + month
			+ "," + date + ")";
	try {
	stmt.executeUpdate(sql1);
	} catch (Exception e) {
	out.println("DB 연동 오류입니다.(3번) : " + e.getMessage());
	}
	%>
	<center>
		<h2>회원가입이 완료되었습니다</h2>
		<img src="image/green_tree.gif"> <a href="login.jsp"> 로그인 하기</a>
	</center>
	<%
	}
	}
	stmt.close();
	conn.close();
	%>
</body>
</html>