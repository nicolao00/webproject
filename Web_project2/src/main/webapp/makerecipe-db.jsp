<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("UTF-8");
Cookie[] cookies = request.getCookies();
%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.TimeZone"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 파일이 저장되는 경로
	String path = getServletContext().getRealPath("recipefolder");
	//out.println(path);
	%>

	<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql_update;
	String name, content, tag, myname, totalstep="";
	String totalin = "";
	String sql;
	int i = 0, cnt = 0;
	int view = 0, likes = 0;
	int new_id = 0;
	//----------------------------
	int size = 1024 * 1024 * 15; // 저장가능한 파일 크기
	String file = ""; // 업로드 한 파일의 이름(이름이 변경될수 있다)
	String originalFile = ""; // 이름이 변경되기 전 실제 파일 이름
	MultipartRequest multi = null;
	// 실제로 파일 업로드하는 과정
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcurl = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		conn = DriverManager.getConnection(jdbcurl, "root", "0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		//------------------------------
		multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String str;
		while (files.hasMoreElements()) {
			str = (String) files.nextElement(); // 파일 이름을 받아와 string으로 저장
			//out.println(str);
			if (str.equals("mainimage1")) {
		file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
			}
			originalFile = multi.getOriginalFileName(str); // 원래의 파일이름 가져옴
		}

		out.println("됨");
	} catch (Exception e) {
		out.println("안됨");
		out.println("연동 오류입니다. : " + e.getMessage());
		e.printStackTrace();
	}
	%>
	<%
	name = multi.getParameter("menu_name");
	content = multi.getParameter("menu_explain");
	String ingredient[] = multi.getParameterValues("ingredient");
	String amount[] = multi.getParameterValues("amount");

	for (i = 0; i < ingredient.length; i++) {
		totalin = totalin + ingredient[i] + "/" + amount[i] + "&";
	}
	String step_explain[] = multi.getParameterValues("step_explain");

	for (i = 0; i < step_explain.length; i++) {
		totalstep = totalstep + step_explain[i] + "&";
	}
	tag = multi.getParameter("tag");
	myname = getCookieValue(cookies, "NAME");
	//날짜 설정
	Date now = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(now);

	try {

		sql = "select max(id) as max_id, count(*) as cnt from recipe";
		rs = stmt.executeQuery(sql);

	} catch (Exception e) {
		out.println("DB 연동 오류입니다.:" + e.getMessage());
	}

	while (rs.next()) {
		cnt = rs.getInt("cnt");
		if (cnt != 0)
			new_id = rs.getInt("max_id");
	}
	new_id++;

	sql_update = "insert into recipe values(" + new_id + ",'" + name + "','" + content + "','" + totalin + "','"
			+ totalstep + "','" + file + "','" + tag + "','" + myname + "','" + strdate + "'," + view + "," + likes
			+ ")";

	try {
		stmt.executeUpdate(sql_update);

	} catch (Exception e) {
		out.println("DB 연동 오류입니다.:" + e.getMessage());
	}
	//--------------------------- 설명 이미지들 DB저장
	Enumeration files = multi.getFileNames();
	String str;
	while (files.hasMoreElements()) {
		str = (String) files.nextElement(); // 파일 이름을 받아와 string으로 저장
		out.println(str);
		if (!str.equals("mainimage1")) {
			file = multi.getFilesystemName(str); // 업로드 된 파일 이름 가져옴
			sql_update = "insert into images values(" + new_id + ",'" + file + "')";
			try {
		stmt.executeUpdate(sql_update);

			} catch (Exception e) {
		out.println("DB 연동 오류입니다.:" + e.getMessage());
			}
		}
	}
	response.sendRedirect("recipepage.jsp");
	%>
	<script>
		//location.href = "question_board.jsp";
	</script>
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