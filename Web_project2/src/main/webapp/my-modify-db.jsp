<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");
Cookie[] cookies = request.getCookies();
%>
<html>
<body>
	<%
	int ref;
	String passwd = "", sql, sql1;
	String name, e_mail;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	name = getCookieValue(cookies, "NAME");
	int year, month, date;
	passwd = request.getParameter("passwd");
	e_mail = request.getParameter("e_mail") + "@" + request.getParameter("e_mail2");
	if (name == "" || passwd == "" || request.getParameter("year") == "" || request.getParameter("month") == ""
			|| request.getParameter("date") == "") {
	%>
	<center>
		<h2>잘못된 입력입니다</h2>
		<a href="my-modify.jsp">뒤로</a>
	</center>
	<%
	} else if (name.length() > 10 || passwd.length() > 20 || e_mail.length() > 40
			|| request.getParameter("year").length() > 4 || request.getParameter("month").length() > 2
			|| request.getParameter("date").length() > 2) {
	%>
	<center>
		<h2>길이를 지켜주세요</h2>
		<a href="my-modify.jsp">뒤로</a>
	</center>
	<%
	} else {
	year = Integer.parseInt(request.getParameter("year"));
	month = Integer.parseInt(request.getParameter("month"));
	date = Integer.parseInt(request.getParameter("date"));
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(url, "root", "0000");
		stmt = conn.createStatement();
		sql = "select * from user where name='" + name + "'";
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	%>
	<%
	sql1 = "update user set passwd='" + passwd + "', email='" + e_mail + "'," + "year=" + year + ",month=" + month
			+ ",date=" + date + " where name = '" + name + "'";
	try {
		stmt.executeUpdate(sql1);
	} catch (Exception e) {
		out.println("DB 연동 오류입니다. : " + e.getMessage());
	}
	%>
	<center>
		<h2>정보가 수정되었습니다</h2>
		<a href="mypage.jsp">마이페이지로</a>
	</center>
	<%
	}
	stmt.close();
	conn.close();
	%>
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