<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
request.setCharacterEncoding("utf-8");
%>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="board-insert.css">
</head>
<body>
<div class="contents"><br>
        <table>
        <tr>
        <td class="logo"><a href="mainpage.jsp"><img src="images/mainimage.png" class="mainimage"> 허브레시피</a></td>
        </tr>
        </table>
    </div>
      <br>
    <div class="notice">
        게시판 > 글쓰기
        <button type="button" name="list" onclick="location.href='board-list.jsp'">목록</button>
    </div><br>
    <form action="board-insert-db.jsp" method="post" onsubmit="return false">
    <div class="writing-page">
        <table>
            <tr>
            <td>제목:</td>
            <td class="head"><input type="text"></td>
            </tr>
            <tr>
                <td>내용:</td>
                <td class="content"> <input type="text"></td>
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
</body>
</html>