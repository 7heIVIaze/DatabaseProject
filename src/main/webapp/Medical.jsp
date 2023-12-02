<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Client</title>
</head>
<body>

	<h2>Welcome to Dr.Baby!</h2>
	<h4>User ---------------------------- </h4>
	<h4>원하시는 메뉴를 선택해주세요.</h4>

<%
    // 데이터베이스 연결 정보
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    String USER_UNIVERSITY = "drbaby"; // id
    String USER_PASSWD = "drbaby"; // pw

    Connection conn = null; // Connection object
    Statement stmt = null;   // Statement object

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(URL, USER_UNIVERSITY, USER_PASSWD);
        conn.setAutoCommit(false); // auto-commit disabled
        stmt = conn.createStatement();
%>

<form method="login">
    <p>버전을 선택하세요:</p>
    <button type="submit" name="version" value="1">회원가입</button>
    <button type="submit" name="version" value="2">로그인</button>
    <button type="submit" name="version" value="3">종료</button>
</form>

<%
    // 사용자로부터 입력 받기
    int version = 0;
    if (request.getMethod().equalsIgnoreCase("LOGIN")) {
        version = Integer.parseInt(request.getParameter("version"));

        // 선택에 따라 다른 JSP 페이지로 이동
        if (version == 1) {
            response.sendRedirect("register.jsp"); //회원 가입
        } else if (version == 2) {
            response.sendRedirect("login.jsp"); //로그인
        } else if (version == 3) {
            out.println("종료합니다.");
        }
    }
%>

<%
    } catch (Exception ex) {
        ex.printStackTrace();
        out.println("에러 발생: " + ex.getMessage());
    } finally {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>


</body>
</html>